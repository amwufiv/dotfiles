local status, _ = pcall(require, 'bufdelete')
if not status then
  print('bufdelete is not installed')
  return
end

-- https://github.com/iu/bufdelete.nvim

local opts = {noremap = true}
vim.keymap.set('n', '<leader>bd', ':Bdelete<CR>', opts)
vim.keymap.set('n', '<leader>bn', ':bn<CR>', opts)
vim.keymap.set('n', '<leader>bp', ':bp<CR>', opts)
vim.keymap.set('n', '<leader>ba', ':enew<CR>', opts)
