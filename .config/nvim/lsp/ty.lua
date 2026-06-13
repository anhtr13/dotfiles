---@brief
---
--- https://github.com/astral-sh/ty
---
--- A Language Server Protocol implementation for ty, an extremely fast Python type checker and language server, written in Rust.

--- `ty` can be installed via uv:
---
--- ```sh
--- uv tool install ty@latest
--- ```

---@type vim.lsp.Config
return {
	cmd = { "ty", "server" },
	filetypes = { "python" },
	root_markers = {
		"ty.toml",
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		".git",
	},
}
