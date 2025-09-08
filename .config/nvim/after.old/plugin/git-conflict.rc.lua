local status, conflict = pcall(require, "git-conflict")
if not status then
  return
end
-- https://github.com/akinsho/git-conflict.nvim
conflict.setup {}
