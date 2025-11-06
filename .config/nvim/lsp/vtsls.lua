---@brief
---
--- https://github.com/yioneko/vtsls
---`vtsls` + `@vue/typescript-plugin` to support TypeScript in `.vue` files.
--- See `vue_ls` section and https://github.com/vuejs/language-tools/wiki/Neovim for more information.
---

local vue_language_server_path = vim.fn.expand("$MASON/packages")
	.. "/vue-language-server"
	.. "/node_modules/@vue/language-server"
local vue_plugin = {
	name = "@vue/typescript-plugin",
	location = vue_language_server_path,
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
					vue_plugin,
				},
			},
		},
	},
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
	root_markers = { "tsconfig.json", "package.json", "jsconfig.json", ".git" },
}
