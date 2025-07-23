-- Use Neovim as a language server to inject LSP diagnostics, code actions, formatting, and more via Lua.
-- Provide a way for non-LSP sources to hook into its LSP client
return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "jay-babu/mason-null-ls.nvim", -- auto install formatters, linters via Manson
    "nvimtools/none-ls-extras.nvim",
  },
  keys = {
    { "<s-m-f>", vim.lsp.buf.format, silent = true, desc = "[F]ormat document by none-ls" },
  },

  config = function()
    local mason_null_ls = require("mason-null-ls")
    mason_null_ls.setup({
      ensure_installed = {
        "checkmake",         -- Make formatter
        "stylua",            -- Lua formatter
        "prettierd",         -- TS/JS formatter
        "eslint_d",          -- TS/JS linter
        "shfmt",             -- Shell formatter
        "golines",           -- Go code formatter that shortens long lines
        "goimports-reviser", -- updates Go import lines (adding missing and removing unreferenced), sort goimports by 3-4 groups: std, general, company (optional), and project dependencies
        "black",             -- Python code formatter
      },
      automatic_installation = true,
    })

    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.golines,
        null_ls.builtins.formatting.goimports_reviser.with({
          args = { "-rm-unused", "-set-alias", "-format", "$FILENAME" },
        }),
        null_ls.builtins.formatting.black,

        -- require("none-ls.diagnostics.eslint_d"),
        null_ls.builtins.diagnostics.checkmake,
      },
    })
  end,
}
