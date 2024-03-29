local status, ts_config = pcall(require, 'nvim-treesitter.configs')
if not status then
  print('status is not installed')
  return
end

ts_config.setup{
  highlight = {
    enable = true,

  },
  playground = {
    enable = true,
    disable = { "latex" },
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}

-- require("vim.treesitter.query").set_query("python", "injections", "(string) @comment")

-- set folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
