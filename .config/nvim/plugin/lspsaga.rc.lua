local status, saga = pcall(require, "lspsaga")
if (not status) then
  print('lspsaga is not installed')
  return
end

saga.setup {
  lightbulb = {
    enable = false,
    enable_in_insert = true,
    sign = true,
    sign_priority = 40,
    virtual_text = true,
  },
}

-- saga.init_lsp_saga {
--    code_action_lightbulb = {
--     enable = false
--   }
-- }

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>j', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
vim.keymap.set('n', '<leader>k', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
-- Go to definition
vim.keymap.set("n","gd", "<cmd>Lspsaga goto_definition<CR>")
vim.keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>")
vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)
vim.keymap.set("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")
-- Float terminal
vim.keymap.set("n", "<leader>tf", "<cmd>Lspsaga term_toggle<CR>", { silent = true })
vim.keymap.set({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
-- Call hierarchy
vim.keymap.set("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
vim.keymap.set("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")
