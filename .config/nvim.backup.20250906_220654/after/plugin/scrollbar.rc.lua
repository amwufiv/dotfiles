local status, sb = pcall(require, "scrollbar")
if not status then
  print("scroller is not installed")
  return
end
gs = require("scrollbar.handlers.gitsigns")

sb.setup {

}

gs.setup {}
