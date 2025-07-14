return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.config.opts.noautocmd = true

    dashboard.section.header.val = {
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                     ]],
      [[       ████ ██████           █████      ██                     ]],
      [[      ███████████             █████                             ]],
      [[      █████████ ███████████████████ ███   ███████████   ]],
      [[     █████████  ███    █████████████ █████ ██████████████   ]],
      [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
      [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
      [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
    }

    dashboard.section.buttons.val = {
      dashboard.button("Leader f", "  Float file explorer", "<leader>f"),
      dashboard.button("Leader / f", "󰈞  Telescope find file", "<leader>/f"),
      dashboard.button("Leader / g", "󰈬  Telescope live grep", "<leader>/g"),
      dashboard.button("Leader ?", "󰌌  Buffer local keymaps", "<leader>?"),
      dashboard.button(":q Enter", "  Quit Neovim", ":q<cr>"),
    }

    local handle = io.popen("fortune -s | cowsay")
    local fortune = handle:read("*a")
    handle:close()
    dashboard.section.footer.val = fortune

    alpha.setup(dashboard.config)
  end,
}
