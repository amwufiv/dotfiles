local api = vim.api

-- Highlight on yank
local winGroup = api.nvim_create_augroup("winGroup", { clear = false })
api.nvim_create_autocmd("WinNew", {
  pattern = "*",
  command = "wincmd L",
  group = winGroup,
})
