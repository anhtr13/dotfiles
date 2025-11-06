return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    local wk = require("which-key")
    wk.add({
      {
        "<leader>?",
        function()
          require("which-key").show({
            global = true,
          })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    })
    wk.setup({
      preset = "modern",
      win = {
        height = {
          min = 4,
          max = 16,
        },
        wo = {
          winblend = 30, -- value between 0-100 0 for fully opaque and 100 for fully transparent
        },
      },
      keys = {
        scroll_up = "<c-u>",
        scroll_down = "<c-d>",
      },
    })
  end,
}
