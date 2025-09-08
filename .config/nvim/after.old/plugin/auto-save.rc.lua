local status, as = pcall(require, "auto-save")
if not status then
  print("auto-save is not installed")
  return
end

as.setup {
  -- enabled = false,
}

-- vim.api.nvim_set_keymap("n", "<leader>n", ":ASToggle<CR>", {})

