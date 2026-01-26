vim.lsp.config("*", {
	capabilities = {
		textDocument = {
			semanticTokens = {
				multilineTokenSupport = true,
			},
		},
	},
})

vim.lsp.enable({
	"bash_ls",
	"clangd",
	"cmake_ls",
	"dockerfile_ls",
	"gopls",
	"json_ls",
	"lua_ls",
	"nginx_ls",
	"pylyzer",
	"rust_analyzer",
	"systemd_ls",
	"tailwind_ls",
	"vtsls",
	"vue_ls",
	"yaml_ls",
})
