local status, tree = pcall(require, "nvim-tree")
if (not status) then
  print('nvim-tree is not installed')
end

-- :help nvim-tree-default-mappings

tree.setup{
  hijack_cursor = true,
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true
  },
  renderer = {
    full_name = true,
    highlight_opened_files = "all"
  },
  filters = {
    dotfiles = true,
    custom = {},
    exclude = {".git"}
  }
}

local opts = {noremap = true}
vim.keymap.set('n','<leader>tt',':NvimTreeToggle<CR>', opts)

-- auto close
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
      vim.cmd "quit"
    end
  end
})
