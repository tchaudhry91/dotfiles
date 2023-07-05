vim.keymap.set("i", "jk", "<Esc>")
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>f", vim.cmd.NERDTreeToggle)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

-- Clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+y")

-- Terminal
vim.keymap.set("t", "jk", "<C-\\><C-n>")
