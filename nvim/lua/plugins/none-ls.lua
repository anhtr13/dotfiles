return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"jayp0521/mason-null-ls.nvim",
	},
	keys = {
		{ "<s-m-f>", vim.lsp.buf.format, silent = true, desc = "[F]ormat document by none-ls" },
	},
	config = function()
		local null_ls = require("null-ls")
		local mason_null_ls = require("mason-null-ls")
		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics

		mason_null_ls.setup({
			ensure_installed = {
				"checkmake", -- make formatter
				"stylua", -- lua formatter
				"prettier", -- ts/js formatter
				"eslint_d", -- ts/js linter
				"shfmt", -- shell formatter
			},
			automatic_installation = true, -- auto-install configured formatters & linters (with null-ls)
		})

		null_ls.setup({
			sources = {
				formatting.prettier,
				formatting.stylua,

				diagnostics.erb_lint,
				diagnostics.checkmake,
			},
		})
	end,
}
