---@brief
---
--- https://github.com/psacawa/systemd-language-server
--- Language Server for Systemd unit files
---
---@type vim.lsp.Config
return {
  cmd = { 'systemd-language-server' },
  filetypes = { 'systemd' },
  root_markers = { '.git' },
}
