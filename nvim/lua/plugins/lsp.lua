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
		vim.lsp.config["bashls"] = {
			cmd = { "bash-language-server", "start" },
			filetypes = { "sh", "zsh" },
		}
		vim.lsp.config["clangd"] = {
			cmd = { "clangd" },
			root_markers = { ".clangd", "compile_commands.json" },
			filetypes = { "c", "cpp", "h", "hpp" },
		}
		vim.lsp.config["codelldb"] = {
			cmd = { "codelldb" },
			filetypes = { "c", "cpp", "h", "hpp" },
		}
		vim.lsp.config["cmakels"] = {
			cmd = { "cmake-language-server" },
			filetypes = { "cmake" },
		}
		vim.lsp.config["docker_ls"] = {
			cmd = { "docker-langserver", "--stdio" },
			filetypes = { "dockerfile" },
		}
		vim.lsp.config["gopls"] = {
			cmd = { "gopls" },
			root_markers = { "go.mod", "go.sum" },
			filetypes = { "go" },
		}
		vim.lsp.config["jsonls"] = {
			cmd = { "vscode-json-language-server", "--stdio" },
			filetypes = { "json" },
		}
		vim.lsp.config["luals"] = {
			cmd = { "lua-language-server" },
			filetypes = { "lua" },
			root_markers = { ".luarc.json", ".luarc.jsonc" },
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
				},
			},
		}
		vim.lsp.config["protols"] = {
			cmd = { "protols" },
			filetypes = { "protobuf", "proto" },
		}
		vim.lsp.config["pylyzer"] = {
			cmd = { "pylyzer", "--server" },
			filetypes = { "python" },
		}
		vim.lsp.config["rust_analyzer"] = {
			cmd = { "rust-analyzer" },
			filetypes = { "rust" },
			root_markers = { "Cargo.toml" },
		}
		vim.lsp.config["sqls"] = {
			cmd = { "sqls" },
			filetypes = { "sql" },
		}
		vim.lsp.config["tailwindls"] = {
			cmd = { "tailwindcss-language-server" },
			filetypes = {
				"javascriptreact",
				"javascript.jsx",
				"typescriptreact",
				"typescript.tsx",
			},
			root_markers = { "tailwind.config.js", "tailwind.config.ts" },
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

		-- Don't forget to enable LSP servers
		vim.lsp.enable("bashls")
		vim.lsp.enable("clangd")
		vim.lsp.enable("codelldb")
		vim.lsp.enable("cmakels")
		vim.lsp.enable("docker_ls")
		vim.lsp.enable("gopls")
		vim.lsp.enable("jsonls")
		vim.lsp.enable("luals")
		vim.lsp.enable("protols")
		vim.lsp.enable("pylyzer")
		vim.lsp.enable("rust_analyzer")
		vim.lsp.enable("sqls")
		vim.lsp.enable("tailwindls")
		vim.lsp.enable("ts_ls")

		vim.keymap.set("n", "grh", function()
			vim.lsp.buf.hover({ border = "single", max_height = 32, max_width = 132 })
		end, { desc = "vim.lsp.buf.hover()", noremap = true, silent = true })
		vim.keymap.set(
			"n",
			"grd",
			vim.lsp.buf.definition,
			{ desc = "vim.lsp.buf.definition()", noremap = true, silent = true }
		)
	end,
}
