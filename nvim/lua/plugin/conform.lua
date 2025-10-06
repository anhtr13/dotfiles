-- Formatter plugin for Neovim
return {
	"stevearc/conform.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<s-m-f>",
			function()
				require("conform").format({ async = true })
			end,
			silent = true,
			desc = "[F]ormat buffer",
		},
	},
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters = {
				clang_format = {
					command = "clang-format",
					args = { "--style", "file", "--fallback-style", "LLVM" },
				},
				goimports_reviser = {
					command = "goimports-reviser",
					args = { "-rm-unused", "-set-alias", "-output", "stdout", "-format", "$FILENAME" },
				},
				golines = {
					command = "golines",
					args = { "--max-len", "132", "--tab-len", "2", "--shorten-comments" }, -- no "$FILENAME" to read from stdout of the previous plugin (goimports_reviser)
				},
				json_fmt = {
					command = "jq",
					args = { ".", "$FILENAME" },
				},
				nginxfmt = {
					command = "nginxfmt",
					args = { "-p", "-i", "4", "$FILENAME" },
				},
				sql_formatter = {
					command = "sql-formatter",
					args = {
						"--config",
						[[{
              "language": "postgresql",
              "useTabs": true,
              "tabWidth": 2,
              "keywordCase": "upper",
              "dataTypeCase": "lower",
              "identifierCase": "lower",
              "functionCase": "lower",
              "linesBetweenQueries": 1,
              "newlineBeforeSemicolon": false
            }]],
					},
				},
			},
			formatters_by_ft = {
				go = { "goimports_reviser", "golines" },
				sql = { "sql_formatter" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				sh = { "shfmt" },
				zsh = { "shfmt" },
				bash = { "shfmt" },
				json = { "json_fmt" },
				nginx = { "nginxfmt" },
				lua = { "stylua" },
				python = { "isort", "black" },
				rust = { "rustfmt" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				vue = { "prettierd", "prettier", stop_after_first = true },
				-- Use the "*" filetype to run formatters on all filetypes.
				["*"] = { "codespell" },
				-- Use the "_" filetype to run formatters on filetypes that don't have other formatters configured.
				["_"] = { "trim_whitespace" },
			},
			-- Set default options
			default_format_opts = {
				lsp_format = "fallback",
				stop_after_first = false,
			},
		})
	end,
}
