local status, yanky = pcall(require, "yanky")
if not status then
  print("yanky is not installed")
  return
end

yanky.setup {
  ring = {
    history_length = 100,
    storage = "sqlite",
    sync_with_numbered_registers = true,
    cancel_event = "update",
  },
  system_clipboard = {
    sync_with_ring = true,
  },
  preserve_cursor_position = {
    enabled = true,
  },


}

vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)")
-- vim.keymap.set({"n","x"}, "gp", "<Plug>(YankyGPutAfter)")
-- vim.keymap.set({"n","x"}, "gP", "<Plug>(YankyGPutBefore)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")
