---@brief
---
--- https://pypi.org/project/nginx-language-server/
---
--- `nginx-language-server` can be installed via uv:
---
--- ```sh
--- uv tool install nginx-language-server@latest
--- ```

---@type vim.lsp.Config
return {
	cmd = { "nginx-language-server" },
	filetypes = { "nginx" },
	root_markers = { "nginx.conf", ".git" },
}
