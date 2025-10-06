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
	-- "ts_ls",
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

-- Identify docker compose files (no longer needed since using yaml_ls)
-- vim.filetype.add({
--   pattern = {
--     ["compose.*%.ya?ml"] = "yaml.docker-compose",
--     ["docker%-compose.*%.ya?ml"] = "yaml.docker-compose",
--   },
-- })

-- Diagnostic display
vim.diagnostic.config({ virtual_text = true })
-- vim.diagnostic.config({ virtual_lines = true })

-- Set keymaps
vim.keymap.set("n", "grh", function()
	vim.lsp.buf.hover({ border = "single", max_height = 32, max_width = 132 })
end, { desc = "vim.lsp.buf.hover()", noremap = true, silent = true })
vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "vim.lsp.buf.definition()", noremap = true, silent = true })
vim.keymap.set(
	"n",
	"grt",
	vim.lsp.buf.type_definition,
	{ desc = "vim.lsp.buf.type_definition()", noremap = true, silent = true }
)
vim.keymap.set("n", "grI", function()
	vim.diagnostic.open_float({ border = "single", max_height = 32, max_width = 132 })
end, { desc = "vim.diagnostic.open_float(),", noremap = true, silent = true })
