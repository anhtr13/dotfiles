---@diagnostic disable:undefined-field

-- ====================
-- Utils
-- ====================

local function rust_reload_workspace(bufnr)
	local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "rust_analyzer" })
	for _, client in ipairs(clients) do
		vim.notify("Reloading Cargo Workspace")
		---@diagnostic disable-next-line:param-type-mismatch
		client:request("rust-analyzer/reloadWorkspace", nil, function(err)
			if err then
				error(tostring(err))
			end
			vim.notify("Cargo workspace reloaded")
		end, 0)
	end
end

local function rust_is_library(fname)
	local user_home = vim.fs.normalize(vim.env.HOME)
	local cargo_home = os.getenv("CARGO_HOME") or user_home .. "/.cargo"
	local registry = cargo_home .. "/registry/src"
	local git_registry = cargo_home .. "/git/checkouts"
	local rustup_home = os.getenv("RUSTUP_HOME") or user_home .. "/.rustup"
	local toolchains = rustup_home .. "/toolchains"
	for _, item in ipairs({ toolchains, registry, git_registry }) do
		if vim.fs.relpath(item, fname) then
			local clients = vim.lsp.get_clients({ name = "rust_analyzer" })
			return #clients > 0 and clients[#clients].config.root_dir or nil
		end
	end
end

--------------------------------------
local function clangd_switch_source_header(bufnr, client)
	local method_name = "textDocument/switchSourceHeader"
	---@diagnostic disable-next-line:param-type-mismatch
	if not client or not client:supports_method(method_name) then
		return vim.notify(("method %s is not supported by any servers active on the current buffer"):format(method_name))
	end
	local params = vim.lsp.util.make_text_document_params(bufnr)
	---@diagnostic disable-next-line:param-type-mismatch
	client:request(method_name, params, function(err, result)
		if err then
			error(tostring(err))
		end
		if not result then
			vim.notify("corresponding file cannot be determined")
			return
		end
		vim.cmd.edit(vim.uri_to_fname(result))
	end, bufnr)
end

local function clangd_symbol_info(bufnr, client)
	local method_name = "textDocument/symbolInfo"
	---@diagnostic disable-next-line:param-type-mismatch
	if not client or not client:supports_method(method_name) then
		return vim.notify("Clangd client not found", vim.log.levels.ERROR)
	end
	local win = vim.api.nvim_get_current_win()
	local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
	---@diagnostic disable-next-line:param-type-mismatch
	client:request(method_name, params, function(err, res)
		if err or #res == 0 then
			-- Clangd always returns an error, there is no reason to parse it
			return
		end
		local container = string.format("container: %s", res[1].containerName) ---@type string
		local name = string.format("name: %s", res[1].name) ---@type string
		vim.lsp.util.open_floating_preview({ name, container }, "", {
			height = 2,
			width = math.max(string.len(name), string.len(container)),
			focusable = false,
			focus = false,
			title = "Symbol Info",
		})
	end, bufnr)
end

--------------------------------------
local mod_cache = nil
local std_lib = nil
local function identify_go_dir(custom_args, on_complete)
	local cmd = { "go", "env", custom_args.envvar_id }
	vim.system(cmd, { text = true }, function(output)
		local res = vim.trim(output.stdout or "")
		if output.code == 0 and res ~= "" then
			if custom_args.custom_subdir and custom_args.custom_subdir ~= "" then
				res = res .. custom_args.custom_subdir
			end
			on_complete(res)
		else
			vim.schedule(function()
				vim.notify(
					("[gopls] identify " .. custom_args.envvar_id .. " dir cmd failed with code %d: %s\n%s"):format(
						output.code,
						vim.inspect(cmd),
						output.stderr
					)
				)
			end)
			on_complete(nil)
		end
	end)
end

local function gopls_get_std_lib_dir()
	if std_lib and std_lib ~= "" then
		return std_lib
	end
	identify_go_dir({ envvar_id = "GOROOT", custom_subdir = "/src" }, function(dir)
		if dir then
			std_lib = dir
		end
	end)
	return std_lib
end

local function gopls_get_mod_cache_dir()
	if mod_cache and mod_cache ~= "" then
		return mod_cache
	end
	identify_go_dir({ envvar_id = "GOMODCACHE" }, function(dir)
		if dir then
			mod_cache = dir
		end
	end)
	return mod_cache
end

local function gopls_get_root_dir(fname)
	if mod_cache and fname:sub(1, #mod_cache) == mod_cache then
		local clients = vim.lsp.get_clients({ name = "gopls" })
		if #clients > 0 then
			return clients[#clients].config.root_dir
		end
	end
	if std_lib and fname:sub(1, #std_lib) == std_lib then
		local clients = vim.lsp.get_clients({ name = "gopls" })
		if #clients > 0 then
			return clients[#clients].config.root_dir
		end
	end
	return vim.fs.root(fname, "go.work") or vim.fs.root(fname, "go.mod") or vim.fs.root(fname, ".git")
end

--------------------------------------
local vue_language_server_path = vim.fn.expand("$MASON/packages") .. "/vue-language-server" .. "/node_modules/@vue/language-server"
local vue_plugin = {
	name = "@vue/typescript-plugin",
	location = vue_language_server_path,
	languages = { "vue" },
	configNamespace = "typescript",
}

-- ====================
-- Configs
-- ====================

vim.lsp.config["bash_ls"] = {
	cmd = { "bash-language-server", "start" },
	settings = {
		bashIde = {
			globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
		},
	},
	filetypes = { "bash", "sh", "zsh" },
	root_markers = { ".git" },
}

--------------------------------------
vim.lsp.config["clangd"] = {
	cmd = { "clangd" },
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	root_markers = {
		".clangd",
		".clang-tidy",
		".clang-format",
		"compile_commands.json",
		"compile_flags.txt",
		"configure.ac", -- AutoTools
		".git",
	},
	capabilities = {
		textDocument = {
			completion = {
				editsNearCursor = true,
			},
		},
		offsetEncoding = { "utf-8", "utf-16" },
	},
	on_init = function(client, init_result)
		if init_result.offsetEncoding then
			client.offset_encoding = init_result.offsetEncoding
		end
	end,
	on_attach = function(client, bufnr)
		vim.api.nvim_buf_create_user_command(bufnr, "LspClangdSwitchSourceHeader", function()
			clangd_switch_source_header(bufnr, client)
		end, { desc = "Switch between source/header" })

		vim.api.nvim_buf_create_user_command(bufnr, "LspClangdShowSymbolInfo", function()
			clangd_symbol_info(bufnr, client)
		end, { desc = "Show symbol info" })
	end,
}

--------------------------------------
vim.lsp.config["cmake_ls"] = {
	cmd = { "cmake-language-server" },
	filetypes = { "cmake" },
	root_markers = { "CMakePresets.json", "CTestConfig.cmake", ".git", "build", "cmake" },
	init_options = {
		buildDirectory = "build",
	},
}

--------------------------------------
vim.lsp.config["dockerfile_ls"] = {
	cmd = { "docker-langserver", "--stdio" },
	filetypes = { "dockerfile" },
	root_markers = { "Dockerfile" },
}

--------------------------------------
vim.lsp.config["gopls"] = {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		gopls_get_mod_cache_dir()
		gopls_get_std_lib_dir()
		-- see: https://github.com/neovim/nvim-lspconfig/issues/804
		on_dir(gopls_get_root_dir(fname))
	end,
}

--------------------------------------
vim.lsp.config["json_ls"] = {
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	init_options = {
		provideFormatter = true,
	},
	root_markers = { ".git" },
}

--------------------------------------
vim.lsp.config["lua_ls"] = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = {
		".luarc.json",
		".luarc.jsonc",
		".luacheckrc",
		".stylua.toml",
		"stylua.toml",
		"selene.toml",
		"selene.yml",
	},
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
}

--------------------------------------
vim.lsp.config["nginx_ls"] = {
	cmd = { "nginx-language-server" },
	filetypes = { "nginx" },
	root_markers = { "nginx.conf", ".git" },
}

--------------------------------------
vim.lsp.config["pylyzer"] = {
	cmd = { "pylyzer", "--server" },
	filetypes = { "python" },
	root_markers = {
		"setup.py",
		"tox.ini",
		"requirements.txt",
		"Pipfile",
		"pyproject.toml",
		".git",
	},
	settings = {
		python = {
			diagnostics = true,
			inlayHints = true,
			smartCompletion = true,
			checkOnType = false,
		},
	},
	cmd_env = {
		ERG_PATH = vim.env.ERG_PATH or vim.fs.joinpath(vim.uv.os_homedir(), ".erg"),
	},
}

--------------------------------------
vim.lsp.config["rust_analyzer"] = {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		local reused_dir = rust_is_library(fname)
		if reused_dir then
			on_dir(reused_dir)
			return
		end
		local cargo_crate_dir = vim.fs.root(fname, { "Cargo.toml" })
		local cargo_workspace_root
		if cargo_crate_dir == nil then
			on_dir(vim.fs.root(fname, { "rust-project.json" }) or vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1]))
			return
		end
		local cmd = {
			"cargo",
			"metadata",
			"--no-deps",
			"--format-version",
			"1",
			"--manifest-path",
			cargo_crate_dir .. "/Cargo.toml",
		}
		vim.system(cmd, { text = true }, function(output)
			if output.code == 0 then
				if output.stdout then
					local result = vim.json.decode(output.stdout)
					if result["workspace_root"] then
						cargo_workspace_root = vim.fs.normalize(result["workspace_root"])
					end
				end
				on_dir(cargo_workspace_root or cargo_crate_dir)
			else
				vim.schedule(function()
					vim.notify(("[rust_analyzer] cmd failed with code %d: %s\n%s"):format(output.code, cmd, output.stderr))
				end)
			end
		end)
	end,
	capabilities = {
		experimental = {
			serverStatusNotification = true,
		},
	},
	before_init = function(init_params, config)
		-- See https://github.com/rust-lang/rust-analyzer/blob/eb5da56d839ae0a9e9f50774fa3eb78eb0964550/docs/dev/lsp-extensions.md?plain=1#L26
		if config.settings and config.settings["rust-analyzer"] then
			init_params.initializationOptions = config.settings["rust-analyzer"]
		end
	end,
	on_attach = function(_, bufnr)
		vim.api.nvim_buf_create_user_command(bufnr, "LspCargoReload", function()
			rust_reload_workspace(bufnr)
		end, { desc = "Reload current cargo workspace" })
	end,
}

--------------------------------------
vim.lsp.config["systemd_ls"] = {
	cmd = { "systemd-language-server" },
	filetypes = { "systemd" },
	root_markers = { ".git" },
}

--------------------------------------
vim.lsp.config["tailwind_ls"] = {
	cmd = { "tailwindcss-language-server", "--stdio" },
	filetypes = {
		"aspnetcorerazor",
		"astro",
		"astro-markdown",
		"blade",
		"clojure",
		"django-html",
		"htmldjango",
		"edge",
		"eelixir", -- vim ft
		"elixir",
		"ejs",
		"erb",
		"eruby", -- vim ft
		"gohtml",
		"gohtmltmpl",
		"haml",
		"handlebars",
		"hbs",
		"html",
		"htmlangular",
		"html-eex",
		"heex",
		"jade",
		"leaf",
		"liquid",
		"markdown",
		"mdx",
		"mustache",
		"njk",
		"nunjucks",
		"php",
		"razor",
		"slim",
		"twig",
		"css",
		"less",
		"postcss",
		"sass",
		"scss",
		"stylus",
		"sugarss",
		"javascript",
		"javascriptreact",
		"reason",
		"rescript",
		"typescript",
		"typescriptreact",
		"vue",
		"svelte",
		"templ",
	},
	settings = {
		tailwindCSS = {
			validate = true,
			lint = {
				cssConflict = "warning",
				invalidApply = "error",
				invalidScreen = "error",
				invalidVariant = "error",
				invalidConfigPath = "error",
				invalidTailwindDirective = "error",
				recommendedVariantOrder = "warning",
			},
			classAttributes = {
				"class",
				"className",
				"class:list",
				"classList",
				"ngClass",
			},
			includeLanguages = {
				eelixir = "html-eex",
				elixir = "phoenix-heex",
				eruby = "erb",
				heex = "phoenix-heex",
				htmlangular = "html",
				templ = "html",
			},
		},
	},
	before_init = function(_, config)
		if not config.settings then
			config.settings = {}
		end
		if not config.settings.editor then
			config.settings.editor = {}
		end
	end,
	workspace_required = true,
	root_dir = function(bufnr, on_dir)
		local root_files = {
			"tailwind.config.js",
			"tailwind.config.cjs",
			"tailwind.config.mjs",
			"tailwind.config.ts",
			"postcss.config.js",
			"postcss.config.cjs",
			"postcss.config.mjs",
			"postcss.config.ts",
			"theme/static_src/tailwind.config.js",
			"theme/static_src/tailwind.config.cjs",
			"theme/static_src/tailwind.config.mjs",
			"theme/static_src/tailwind.config.ts",
			"theme/static_src/postcss.config.js",
			"vite.config.js",
			"vite.config.ts",
		}
		local fname = vim.api.nvim_buf_get_name(bufnr)
		on_dir(vim.fs.dirname(vim.fs.find(root_files, { path = fname, upward = true })[1]))
	end,
}

--------------------------------------
vim.lsp.config["vtsls"] = {
	cmd = { "vtsls", "--stdio" },
	init_options = {
		hostInfo = "neovim",
	},
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					vue_plugin,
				},
			},
		},
	},
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
	root_markers = { "tsconfig.json", "package.json", "jsconfig.json", ".git" },
}

--------------------------------------
vim.lsp.config["vue_ls"] = {
	cmd = { "vue-language-server", "--stdio" },
	filetypes = { "vue" },
	root_markers = { "package.json" },
	on_init = function(client)
		local retries = 0
		local function typescriptHandler(_, result, context)
			local ts_client = vim.lsp.get_clients({ bufnr = context.bufnr, name = "ts_ls" })[1]
				or vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })[1]
				or vim.lsp.get_clients({ bufnr = context.bufnr, name = "typescript-tools" })[1]

			if not ts_client then
				-- there can sometimes be a short delay until `ts_ls`/`vtsls` are attached so we retry for a few times until it is ready
				if retries <= 10 then
					retries = retries + 1
					vim.defer_fn(function()
						typescriptHandler(_, result, context)
					end, 100)
				else
					vim.notify("Could not find `ts_ls`, `vtsls`, or `typescript-tools` lsp client required by `vue_ls`.", vim.log.levels.ERROR)
				end
				return
			end
			local param = unpack(result)
			local id, command, payload = unpack(param)
			ts_client:exec_cmd({
				title = "vue_request_forward", -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
				command = "typescript.tsserverRequest",
				arguments = {
					command,
					payload,
				},
			}, { bufnr = context.bufnr }, function(_, r)
				local response_data = { { id, r and r.body } }
				---@diagnostic disable-next-line: param-type-mismatch
				client:notify("tsserver/response", response_data)
			end)
		end
		client.handlers["tsserver/request"] = typescriptHandler
	end,
}

--------------------------------------
vim.lsp.config["yaml_ls"] = {
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values" },
	root_markers = { ".git" },
	settings = {
		-- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
		redhat = { telemetry = { enabled = false } },
	},
}

--------------------------------------
vim.lsp.config("*", {
	capabilities = {
		textDocument = {
			semanticTokens = {
				multilineTokenSupport = true,
			},
		},
	},
})

-- ====================
-- Enable
-- ====================

vim.lsp.enable({
	"bash_ls",
	"clangd",
	"cmake_ls",
	"dockerfile_ls",
	"gopls",
	"json_ls",
	"lua_ls",
	"nginx_ls",
	"pylyzer",
	"rust_analyzer",
	"systemd_ls",
	"tailwind_ls",
	"vtsls",
	"vue_ls",
	"yaml_ls",
})
