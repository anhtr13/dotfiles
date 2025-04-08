local opts = { silent = true }
local setmap = vim.keymap.set

-- save
setmap({ "i", "v" }, "<c-s>", "<ESC><cmd>:w<CR>", opts)
setmap("n", "<c-s>", "<cmd>:w<CR>", opts)

-- quit
setmap({ "n", "i", "v" }, "<c-q>", "<ESC>", opts)

-- undo/redo
setmap("i", "<c-z>", "<ESC>u", opts)
setmap({ "n", "v" }, "<c-z>", "u", opts)
setmap("i", "<c-r>", "<ESC><c-r>", opts) -- redo

-- delete
setmap("i", "<c-BS>", "<ESC>db", opts) -- delete to begin of word
setmap("i", "<c-Del>", "<ESC>de", opts) -- delete to end of word
setmap("i", "<c-s-BS>", "<ESC>d0", opts) -- delete to the begin of line
setmap("i", "<c-s-Del>", "<ESC>d$", opts) -- delete to the end of line

setmap("n", "<c-BS>", "db", opts) -- delete to begin of word
setmap("n", "<c-Del>", "de", opts) -- delete to end of word
setmap("n", "<c-s-BS>", "d0", opts) -- delete to the begin of line
setmap("n", "<c-s-Del>", "d$", opts) -- delete to the end of line

-- buffers
setmap("n", "<Tab>", "<cmd>:bnext<CR>", opts)
setmap("n", "<S-Tab>", "<cmd>:bprevious<CR>", opts)
setmap("n", "<leader>x", "<cmd>:Bdelete!<CR>", opts) -- close buffer

-- newline in normal mode
setmap("n", "<c-CR>", "o<Esc>", { desc = "Add new line below", silent = true })
setmap("n", "<c-s-CR>", "O<Esc>", { desc = "Add new line above", silent = true })
