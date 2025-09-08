local status,ls = pcall(require, 'luasnip')
if (not status) then
  print("luasnip is not install")
  return
end

local s = ls.snippet
local t, i, c, f = ls.text_node, ls.insert_node, ls.choice_node, ls.function_node

----- python snippets
require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/after/plugin/snippets"})
