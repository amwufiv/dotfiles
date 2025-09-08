local api = vim.api

-- group 非必需
local winGroup = api.nvim_create_augroup("winGroup", { clear = false })
api.nvim_create_autocmd("WinNew", {
  pattern = "*",
  command = "wincmd L",
  group = winGroup,
})
