-- Core autocmds
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- General settings
local general = augroup("General", { clear = true })

-- Highlight on yank
autocmd("TextYankPost", {
  group = general,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Auto save on focus lost
autocmd("FocusLost", {
  group = general,
  pattern = "*",
  command = ":wa",
})

-- Remove trailing whitespace
autocmd("BufWritePre", {
  group = general,
  pattern = "*",
  command = ":%s/\\s\\+$//e",
})

-- File type specific
local filetypes = augroup("FileTypes", { clear = true })

-- Set specific options for different file types
autocmd("FileType", {
  group = filetypes,
  pattern = { "python", "lua", "javascript", "typescript" },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end,
})