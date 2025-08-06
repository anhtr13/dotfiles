-- Formatter plugin for Neovim
return {
	"stevearc/conform.nvim",
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
				goimports_reviser = {
					command = "goimports-reviser",
					args = { "-rm-unused", "-set-alias", "-output", "stdout", "-format", "$FILENAME" },
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
				go = { "goimports_reviser" },
				sql = { "sql_formatter" },
				sh = { "shfmt" },
				nginx = { "nginxfmt" },
				lua = { "stylua" },
				python = { "isort", "black" },
				rust = { "rustfmt" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
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
