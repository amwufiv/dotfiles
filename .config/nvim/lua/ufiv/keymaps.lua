local opts = {noremap = true, silent = true}


local keymap = vim.api.nvim_set_keymap

keymap("","<Space>","<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- Better window navigation
keymap("n","<C-h>", "4h", opts)
keymap("n","<C-j>", "4j", opts)
keymap("n","<C-k>", "4k", opts)
keymap("n","<C-l>", "4l", opts)
keymap("v","<C-h>", "4h", opts)
keymap("v","<C-j>", "4j", opts)
keymap("v","<C-k>", "4k", opts)
keymap("v","<C-l>", "4l", opts)


-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- select all
keymap("n", "<leader>a", "ggVG$", opts)

-- quickfix
keymap("n", ",cn", ":cn<CR>", opts)
keymap("n", ",cp", ":cp<CR>", opts)
keymap("n", ",co", ":copen<CR>", opts)
keymap("n", ",cc", ":cclose<CR>", opts)
