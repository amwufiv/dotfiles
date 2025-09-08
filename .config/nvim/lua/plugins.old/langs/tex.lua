-- LaTeX/TeX specific configuration
local M = {}

M.plugins = {
  "lervag/vimtex",
}

M.config = function()
  -- VimTeX configuration
  vim.g.tex_flavor = 'latex'
  vim.g.vimtex_view_method = 'skim'
  vim.g.vimtex_view_skim_sync = 1
  vim.g.vimtex_view_skim_activate = 1
  vim.g.vimtex_quickfix_mode = 0
  vim.g.vimtex_compiler_progname = 'nvr'
  
  -- Concealment settings
  vim.g.vimtex_syntax_conceal_disable = 1
  
  -- Compiler settings
  vim.g.vimtex_compiler_latexmk = {
    build_dir = '',
    callback = 1,
    continuous = 1,
    executable = 'latexmk',
    hooks = {},
    options = {
      '-verbose',
      '-file-line-error',
      '-synctex=1',
      '-interaction=nonstopmode',
    },
  }
  
  -- Folding
  vim.g.vimtex_fold_enabled = 1
  vim.g.vimtex_fold_manual = 1
  vim.g.vimtex_fold_types = {
    cmd_addplot = {
      cmds = { 'addplot[+3]?' }
    },
    cmd_multi = {
      cmds = {
        '%(re)?new%(command|environment)',
        'providecommand',
        'presetkeys',
        'Declare%(Multi|Auto)?CiteCommand',
        'Declare%(Index)?%(Field|List|Name)%(Format|Alias)'
      }
    },
    cmd_single = {
      cmds = { 'hypersetup', 'tikzset', 'pgfplotstableread', 'lstset' }
    },
    cmd_single_opt = {
      cmds = { 'usepackage', 'includepdf' }
    },
    comments = {
      enabled = 0
    },
    env_options = vim.empty_dict(),
    envs = {
      blacklist = {},
      whitelist = { 'figure', 'frame', 'table', 'equation*?', 'align*?' }
    },
    items = {
      enabled = 0
    },
    markers = vim.empty_dict(),
    preamble = {
      enabled = 1
    },
    sections = {
      parse_levels = 0,
      parts = { 'appendix', 'frontmatter', 'mainmatter', 'backmatter' },
      sections = {
        '%(add)?part',
        '%(chapter|addchap)',
        '%(section|addsec)', 
        'subsection', 'subsubsection',
        'paragraph', 'subparagraph'
      }
    }
  }

  -- Keymaps
  vim.keymap.set("n", "<leader>ll", "<cmd>VimtexCompile<cr>")
  vim.keymap.set("n", "<leader>lv", "<cmd>VimtexView<cr>")
  vim.keymap.set("n", "<leader>li", "<cmd>VimtexInfo<cr>")
  vim.keymap.set("n", "<leader>lt", "<cmd>VimtexTocToggle<cr>")
  vim.keymap.set("n", "<leader>lc", "<cmd>VimtexClean<cr>")
end

return M