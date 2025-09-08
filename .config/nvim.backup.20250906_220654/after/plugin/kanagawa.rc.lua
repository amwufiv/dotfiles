
local status, ka = pcall(require, "kanagawa")
if (not status) then
  print("kanagawa is not installed")
  return
end

ka.setup({

})


-- vim.cmd("colorscheme kanagawa")
