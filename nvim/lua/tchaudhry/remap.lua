vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("t", "jk", "<C-\\><C-n>")
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>f", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>`", ":ToggleTerm<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")

vim.keymap.set("n", "J", "mzJ`z")

-- Clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+y")

vim.wo.relativenumber = true
