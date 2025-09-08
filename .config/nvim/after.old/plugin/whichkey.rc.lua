local status, whichkey = pcall(require, "which-key")
if (not status) then
  print("which-key is not installed")
  return
end

-- https://github.com/folke/which-key.nvim


whichkey.setup {

}
