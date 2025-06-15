return {
	-- Mason for installing and managing LSP servers, DAP servers, linters, formatters, etc.
	"mason-org/mason.nvim",
	config = function()
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		vim.lsp.config("*", {
			root_markers = { ".git", ".hg" },
			capabilities = {
				textDocument = {
					semanticTokens = {
						multilineTokenSupport = true,
					},
				},
			},
		})

		-- Config LSP servers after install packages by MasonInstall <package_name>
		vim.lsp.config["bash_ls"] = {
			cmd = { "bash-language-server", "start" },
			filetypes = { "sh", "zsh" },
		}
		vim.lsp.config["clangd"] = {
			cmd = { "clangd" },
			root_markers = {
				".clangd",
				".clang-tidy",
				".clang-format",
				"compile_commands.json",
				"compile_flags.txt",
				"configure.ac",
			},
			filetypes = { "c", "cpp", "h", "hpp", "objc", "objcpp" },
		}
		vim.lsp.config["cmake_ls"] = {
			cmd = { "cmake-language-server" },
			filetypes = { "cmake" },
			root_markers = { "CMakePresets.json", "CTestConfig.cmake", ".git", "build", "cmake" },
		}
		vim.lsp.config["docker_ls"] = {
			cmd = { "docker-langserver", "--stdio" },
			filetypes = { "dockerfile" },
			root_markers = { "Dockerfile" },
		}
		vim.lsp.config["docker_compose_ls"] = {
			cmd = { "docker-compose-langserver", "--stdio" },
			filetypes = { "yaml.docker-compose" },
			root_markers = { "docker-compose.yaml", "docker-compose.yml", "compose.yaml", "compose.yml" },
		}
		vim.lsp.config["gopls"] = {
			cmd = { "gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			root_markers = { "go.mod", "go.sum", "go.work", ".git" },
		}
		vim.lsp.config["json_ls"] = {
			cmd = { "vscode-json-language-server", "--stdio" },
			filetypes = { "json", "jsonc" },
		}
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
				},
			},
		}
		vim.lsp.config["posgres_ls"] = {
			cmd = { "postgrestools", "lsp-proxy" },
			filetypes = { "sql" },
			root_markers = { "postgrestools.jsonc" },
		}
		vim.lsp.config["proto_ls"] = {
			cmd = { "protols" },
			filetypes = { "proto" },
			root_markers = { "protols.toml", ".git" },
		}
		vim.lsp.config["pylyzer"] = {
			cmd = { "pylyzer", "--server" },
			filetypes = { "python" },
			root_markers = {
				"setup.py",
				"tox.ini",
				"requirements.txt",
				"Pipfile",
				"pyproject.toml",
			},
		}
		vim.lsp.config["rust_analyzer"] = {
			cmd = { "rust-analyzer" },
			filetypes = { "rust" },
			root_markers = { "Cargo.toml" },
		}
		vim.lsp.config["tailwind_ls"] = {
			cmd = { "tailwindcss-language-server", "--stdio" },
			filetypes = {
				"html",
				"css",
				"scss",
				"javascriptreact",
				"javascript.jsx",
				"typescriptreact",
				"typescript.t",
				"vue",
				"svelte",
				"templ",
			},
			root_markers = {
				"tailwind.config.js",
				"tailwind.config.cjs",
				"tailwind.config.mjs",
				"tailwind.config.ts",
				"postcss.config.js",
				"postcss.config.cjs",
				"postcss.config.mjs",
				"postcss.config.ts",
				"vite.config.ts",
			},
		}
		vim.lsp.config["ts_ls"] = {
			cmd = { "typescript-language-server", "--stdio" },
			filetypes = {
				"javascript",
				"javascriptreact",
				"javascript.jsx",
				"typescript",
				"typescriptreact",
				"typescript.tsx",
			},
			root_markers = { "tsconfig.json", "jsconfig.json", "package.json" },
		}
		vim.lsp.config["yaml_ls"] = {
			cmd = { "yaml-language-server", "--stdio" },
			filetypes = { "yaml", "yaml.docker-compose" },
		}

		-- Don't forget to enable LSP servers
		vim.lsp.enable("bash_ls")
		vim.lsp.enable("clangd")
		vim.lsp.enable("cmake_ls")
		vim.lsp.enable("docker_ls")
		vim.lsp.enable("docker_compose_ls")
		vim.lsp.enable("gopls")
		vim.lsp.enable("json_ls")
		vim.lsp.enable("lua_ls")
		vim.lsp.enable("posgres_ls")
		vim.lsp.enable("proto_ls")
		vim.lsp.enable("pylyzer")
		vim.lsp.enable("rust_analyzer")
		vim.lsp.enable("tailwind_ls")
		vim.lsp.enable("ts_ls")
		vim.lsp.enable("yaml_ls")

		vim.keymap.set("n", "grh", function()
			vim.lsp.buf.hover({ border = "single", max_height = 32, max_width = 132 })
		end, { desc = "vim.lsp.buf.hover()", noremap = true, silent = true })
		vim.keymap.set(
			"n",
			"grd",
			vim.lsp.buf.definition,
			{ desc = "vim.lsp.buf.definition()", noremap = true, silent = true }
		)
		vim.keymap.set(
			"n",
			"grt",
			vim.lsp.buf.type_definition,
			{ desc = "vim.lsp.buf.type_definition()", noremap = true, silent = true }
		)
		vim.keymap.set("n", "gri", function()
			vim.diagnostic.open_float({ border = "single", max_height = 32, max_width = 132 })
		end, { desc = "vim.diagnostic.open_float(),", noremap = true, silent = true })
	end,
}
