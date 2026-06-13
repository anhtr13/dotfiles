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
	"rust_analyzer",
	"systemd_ls",
	"tailwind_ls",
	"ty",
	"vtsls",
	"vue_ls",
	"yaml_ls",
	"zig_ls",
})
