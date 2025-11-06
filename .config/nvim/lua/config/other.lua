-- Lsps
vim.lsp.enable({
	"bash_ls",
	"clangd",
	"cmake_ls",
	"dockerfile_ls",
	"gopls",
	"json_ls",
	"lua_ls",
	"nginx_ls",
	"proto_ls",
	"pylyzer",
	"rust_analyzer",
	"systemd_ls",
	"tailwind_ls",
	"vtsls",
	"vue_ls",
	"yaml_ls",
})

vim.lsp.config("*", {
	capabilities = {
		textDocument = {
			semanticTokens = {
				multilineTokenSupport = true,
			},
		},
	},
})

-- Colors
vim.api.nvim_set_hl(0, "rose", { ctermbg = 0, fg = "#E06C75", bg = "#31353f" })
vim.api.nvim_set_hl(0, "blue", { ctermbg = 0, fg = "#61AFEF", bg = "#31353f" })
vim.api.nvim_set_hl(0, "green", { ctermbg = 0, fg = "#98C379", bg = "#31353f" })
vim.api.nvim_set_hl(0, "yellow", { ctermbg = 0, fg = "#E5C07B", bg = "#31353f" })

-- Diagnostic displays
vim.diagnostic.config({ virtual_text = true })
-- vim.diagnostic.config({ virtual_lines = true })
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

-- Break-point displays
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "rose", linehl = "rose", numhl = "rose" })
vim.fn.sign_define("DapBreakpointCondition", { text = "󰟃", texthl = "blue", linehl = "blue", numhl = "blue" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "rose", linehl = "rose", numhl = "rose" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "yellow", linehl = "yellow", numhl = "yellow" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "green", linehl = "green", numhl = "green" })

-- Register additional file extensions
-- vim.filetype.add({
--   pattern = {
--     ["compose.*%.ya?ml"] = "yaml.docker-compose",
--     ["docker%-compose.*%.ya?ml"] = "yaml.docker-compose",
--   },
-- })
-- vim.filetype.add({ extension = { tf = "terraform" } })
-- vim.filetype.add({ extension = { tfvars = "terraform" } })
-- vim.filetype.add({ extension = { pipeline = "groovy" } })
-- vim.filetype.add({ extension = { multibranch = "groovy" } })
