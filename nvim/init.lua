require("core.options")
require("core.keymaps")
require("core.lsp")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  require("plugins.themes.tokyo_night"),
  require("plugins.neo-tree"),
  require("plugins.lualine"),
  require("plugins.bufferline"),
  require("plugins.treesitter"),
  require("plugins.telescope"),
  require("plugins.mason"),
  require("plugins.autocompletion"),
  require("plugins.conform"),
  require("plugins.debugger"),
  require("plugins.gitsigns"),
  require("plugins.alpha"),
  require("plugins.indent-line"),
  require("plugins.autopair"),
  require("plugins.which-key"),
  require("plugins.comment"),
  require("plugins.snacks"),
  require("plugins.ufo"),
  require("plugins.ts-autotag"),
})
