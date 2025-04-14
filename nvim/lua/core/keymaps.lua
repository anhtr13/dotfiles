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
-- <c-o> to perform normal mode while in insert mode
-- <c-o> db/dB : delete to begin of word
-- <c-o> de/dE : delete to end of word


-- buffers
setmap("n", "<Tab>", "<cmd>:bnext<CR>", opts)
setmap("n", "<S-Tab>", "<cmd>:bprevious<CR>", opts)
setmap("n", "<leader>x", "<cmd>:Bdelete!<CR>", opts) -- close buffer

-- newline in normal mode
setmap("n", "<leader>G", "o<Esc>", { desc = "Add new line below", silent = true })
setmap("n", "<leader>g", "O<Esc>", { desc = "Add new line above", silent = true })
