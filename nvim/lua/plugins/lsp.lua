return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ensure_installed = {
					"lua_ls",
					"bashls",
					"gopls",
					"ts_ls",
					"clangd",
					"clang-format",
					"codelldb", -- debugger server for clang
					"cmake",
					"dockerls",
					"docker_compose_language_service",
					"sqls",
					"buf_ls", -- Protobuf
					"pyright", -- Python
					"jsonls",
					"yamlls",
					"tailwindcss",
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"bashls",
					"gopls",
					"ts_ls",
					"clangd",
					"cmake",
					"dockerls",
					"docker_compose_language_service",
					"sqls",
					"buf_ls",
					"pyright",
					"jsonls",
					"yamlls",
					"tailwindcss",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.bashls.setup({ capabilities = capabilities })
			lspconfig.ts_ls.setup({ capabilities = capabilities })
			lspconfig.gopls.setup({ capabilities = capabilities })
			lspconfig.clangd.setup({ capabilities = capabilities })
			lspconfig.cmake.setup({ capabilities = capabilities })
			lspconfig.dockerls.setup({ capabilities = capabilities })
			lspconfig.docker_compose_language_service.setup({ capabilities = capabilities })
			lspconfig.sqls.setup({ capabilities = capabilities })
			lspconfig.buf_ls.setup({ capabilities = capabilities })
			lspconfig.pyright.setup({ capabilities = capabilities })
			lspconfig.jsonls.setup({ capabilities = capabilities })
			lspconfig.yamlls.setup({ capabilities = capabilities })
			lspconfig.tailwindcss.setup({ capabilities = capabilities })

			vim.keymap.set("n", "<leader>I", vim.lsp.buf.hover, { desc = "[I]nformation pop up" })
			vim.keymap.set({ "n", "v" }, "<leader>R", vim.lsp.buf.references, { desc = "[R]eferences" })
			vim.keymap.set("n", "<leader>de", vim.lsp.buf.definition, { desc = "Go to [de]finition" })
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[c]ode [a]ction" })
		end,
	},
}
