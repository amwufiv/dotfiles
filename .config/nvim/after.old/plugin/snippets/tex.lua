local ls = require('luasnip')
local s = ls.snippet
local t, i, c, f = ls.text_node, ls.insert_node, ls.choice_node, ls.function_node

return {
    s(
      "init",
      {
        t({
          "% !TEX TS-program = xelatex",
          "% !TEX encoding = UTF-8 Unicode",
          "\\documentclass[UTF8,a4paper,fontset=macnew]{ctexart}",
          "",
          "",
          "\\begin{document}",
          "",
          "",
          "\\end{document}"
        })
      }
    )
}
