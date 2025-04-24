return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",

    "leoluz/nvim-dap-go",
  },
  keys = {
    { "<leader>db", ":DapToggleBreakpoint<CR>", silent = true, desc = "Toggle [D]ebugger [B]reak point" },
    { "<leader>dc", ":DapContinue<CR>",         silent = true, desc = "[D]ebugger [c]ontinue" },
    { "<leader>do", ":DapStepOver<CR>",         silent = true, desc = "[D]ebugger step [o]ver" },
    { "<leader>di", ":DapStepInto<CR>",         silent = true, desc = "[D]ebugger step [i]nto" },
    { "<leader>du", ":DapStepOut<CR>",          silent = true, desc = "[D]ebugger step o[u]t" },
    { "<leader>dx", ":DapTerminate<CR>",        silent = true, desc = "[D]ebugger e[x]it" },
  },
  config = function()
    require("dapui").setup()
    require("dap-go").setup()

    local dap = require("dap")
    local dapui = require("dapui")

    -- setup gdb for debugging C/C++/Rust, requires gdb 14.0+
    -- make sure build file with -g flag before debugging
    dap.adapters.gdb = {
      type = "executable",
      command = "gdb",
      args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
    }
    dap.configurations.c = {
      {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
      },
      {
        name = "Select and attach to process",
        type = "gdb",
        request = "attach",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        pid = function()
          local name = vim.fn.input("Executable name (filter): ")
          return require("dap.utils").pick_process({ filter = name })
        end,
        cwd = "${workspaceFolder}",
      },
      {
        name = "Attach to gdbserver :1234",
        type = "gdb",
        request = "attach",
        target = "localhost:1234",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
      },
    }
    dap.configurations.cpp = {
      {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
      },
      {
        name = "Select and attach to process",
        type = "gdb",
        request = "attach",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        pid = function()
          local name = vim.fn.input("Executable name (filter): ")
          return require("dap.utils").pick_process({ filter = name })
        end,
        cwd = "${workspaceFolder}",
      },
      {
        name = "Attach to gdbserver :1234",
        type = "gdb",
        request = "attach",
        target = "localhost:1234",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
      },
    }

    -- binding dap & dap-ui
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    -- break-point colors
    vim.api.nvim_set_hl(0, "rose", { ctermbg = 0, fg = "#E06C75", bg = "#31353f" })
    vim.api.nvim_set_hl(0, "blue", { ctermbg = 0, fg = "#61AFEF", bg = "#31353f" })
    vim.api.nvim_set_hl(0, "green", { ctermbg = 0, fg = "#98C379", bg = "#31353f" })
    vim.api.nvim_set_hl(0, "yellow", { ctermbg = 0, fg = "#E5C07B", bg = "#31353f" })

    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "rose", linehl = "rose", numhl = "rose" })
    vim.fn.sign_define(
      "DapBreakpointCondition",
      { text = "󰟃", texthl = "blue", linehl = "blue", numhl = "blue" }
    )
    vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "rose", linehl = "rose", numhl = "rose" })
    vim.fn.sign_define("DapLogPoint", { text = "", texthl = "yellow", linehl = "yellow", numhl = "yellow" })
    vim.fn.sign_define("DapStopped", { text = "", texthl = "green", linehl = "green", numhl = "green" })
  end,
}
