---@brief
--- https://github.com/yioneko/vtsls

local language_server_path = vim.fn.expand("$MASON/packages") .. "/vue-language-server" .. "/node_modules/@vue/language-server"
local plugin = {
	name = "@vue/typescript-plugin",
	location = language_server_path,
	languages = { "vue" },
	configNamespace = "typescript",
}

---@type vim.lsp.Config
return {
	cmd = { "vtsls", "--stdio" },
	init_options = {
		hostInfo = "neovim",
	},
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					plugin,
				},
			},
		},
	},
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	root_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock", ".git" },
}
