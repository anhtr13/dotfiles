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
              "functionCase": "lower",
              "linesBetweenQueries": 2,
              "newlineBeforeSemicolon": true
            }]],
					},
				},
			},
			formatters_by_ft = {
				go = { "goimports_reviser", "golines" },
				sql = { "sql_formatter" },
				sh = { "shfmt" },
				nginx = { "nginxfmt" },
				lua = { "stylua" },
				python = { "isort", "black" },
				rust = { "rustfmt" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
			},
			-- Set default options
			default_format_opts = {
				lsp_format = "fallback",
			},
		})
	end,
}
