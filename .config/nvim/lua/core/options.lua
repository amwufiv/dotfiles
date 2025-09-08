-- Core vim options - zero plugin dependencies
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

-- Disable netrw in favor of nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.netrw_browser_viewer = 'open'
vim.g.netrw_http_cmd = 'open'

-- UI
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.hlsearch = true

-- Indentation
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- Search
vim.opt.ignorecase = true

-- Visual indicators
vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↩"

-- System integration
vim.opt.clipboard = "unnamedplus"

-- Neovide specific (conditional)
if vim.g.neovide then
  --integrationn Add neovide specific settings when needed
end
