---@brief
---
--- https://pypi.org/project/nginx-language-server/
---
---@type vim.lsp.Config
return {
  cmd = { 'nginx-language-server' },
  filetypes = { 'nginx' },
  root_markers = { 'nginx.conf', '.git' },
}
