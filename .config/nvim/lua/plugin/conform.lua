-- ############################
-- ##### Formatter plugin #####
-- ############################
--
-- # Require installed formatters:
-- goimports-reviser:      https://github.com/incu6us/goimports-reviser
-- golines:                https://github.com/segmentio/golines
-- shfmt:                  https://github.com/mvdan/sh
-- rustfmt:                https://github.com/rust-lang/rustfmt
-- jq:                     https://github.com/stedolan/jq
-- clang-format:           https://pypi.org/project/clang-format
-- black:                  https://pypi.org/project/black
-- isort:                  https://pypi.org/project/isort
-- prettierd:              https://github.com/fsouza/prettierd
-- sql-formatter:          https://sql-formatter-org.github.io/sql-formatter
-- stylua:                 https://github.com/JohnnyMorganz/StyLua
-- codespell:              https://github.com/codespell-project/codespell
-- nginx-config-formatter: https://github.com/slomkowski/nginx-config-formatter
--

return {
	"stevearc/conform.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<leader>F",
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
				rust = { "rustfmt" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				lua = { "stylua" },
				python = { "isort", "black" },
				sh = { "shfmt" },
				zsh = { "shfmt" },
				bash = { "shfmt" },
				sql = { "sql_formatter" },
				nginx = { "nginxfmt" },
				json = { "json_fmt" },
				jsonc = { "json_fmt" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				vue = { "prettierd", "prettier", stop_after_first = true },
				-- ["*"] = { "codespell" }, -- formatter on all filetypes.
				["_"] = { "trim_whitespace" }, -- formatter on filetypes that don't have other formatters configured.
			},
			default_format_opts = {
				lsp_format = "fallback",
				stop_after_first = false,
			},
		})
	end,
}
