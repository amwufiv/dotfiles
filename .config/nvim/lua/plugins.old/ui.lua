-- UI and theming configuration  
local M = {}

M.plugins = {
  {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' }
  },
  "kyazdani42/nvim-web-devicons",
  "rebelot/kanagawa.nvim",
  "olimorris/onedarkpro.nvim", 
  "glepnir/dashboard-nvim",
  "petertriho/nvim-scrollbar",
  "lukas-reineke/indent-blankline.nvim",
}

M.config = function()
  -- Theme setup
  local kanagawa_ok, kanagawa = pcall(require, "kanagawa")
  if kanagawa_ok then
    kanagawa.setup({
      undercurl = true,
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true},
      statementStyle = { bold = true },
      typeStyle = {},
      variablebuiltinStyle = { italic = true},
      specialReturn = true,
      specialException = true,
      transparent = false,
      dimInactive = false,
      colors = {
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      overrides = function(colors)
        return {}
      end,
    })
  end

  local onedark_ok, onedark = pcall(require, "onedarkpro")
  if onedark_ok then
    onedark.setup({
      dark_theme = "onedark_vivid",
      light_theme = "onelight", 
      colors = {},
      highlights = {},
      filetypes = {
        c = true,
        cpp = true,
        css = true,
        go = true,
        html = true,
        java = true,
        javascript = true,
        lua = true,
        markdown = true,
        php = true,
        python = true,
        ruby = true,
        rust = true,
        scss = true,
        typescript = true,
        vue = true,
        yaml = true,
      },
      plugins = {
        treesitter = true,
      },
      styles = {
        strings = "NONE",
        comments = "italic",
        keywords = "bold,italic",
        functions = "NONE",
        variables = "NONE",
        virtual_text = "NONE",
      },
      options = {
        bold = true,
        italic = true,
        underline = true,
        undercurl = true,
        cursorline = false,
        transparency = false,
        terminal_colors = true,
        highlight_inactive_windows = false,
      }
    })
  end

  -- Set colorscheme
  vim.cmd("colorscheme onedark_vivid")

  -- Lualine
  local lualine_ok, lualine = pcall(require, "lualine")
  if lualine_ok then
    lualine.setup({
      options = {
        icons_enabled = true,
        theme = 'onedark',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {},
        always_divide_middle = true,
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {
          {
            'filename',
            file_status = true,
            path = 1
          }
        },
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      extensions = {'nvim-tree'}
    })
  end

  -- Dashboard
  local dashboard_ok, dashboard = pcall(require, "dashboard")
  if dashboard_ok then
    dashboard.setup({
      theme = 'hyper',
      config = {
        header = {
          '',
          '███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗',
          '████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║',
          '██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║',
          '██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║',
          '██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║',
          '╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝',
          '',
        },
        shortcut = {
          { desc = ' Find File', group = '@property', action = 'Telescope find_files', key = 'f' },
          { desc = ' Recent Files', group = 'Label', action = 'Telescope oldfiles', key = 'r' },
          { desc = ' Configuration', group = 'Number', action = 'edit ~/.config/nvim/init.lua', key = 'c' },
        },
      },
    })
  end

  -- Indent blankline
  local indent_ok, indent = pcall(require, "indent_blankline")
  if indent_ok then
    indent.setup({
      show_current_context = true,
      show_current_context_start = true,
      char = '┊',
      context_char = '┃',
      show_trailing_blankline_indent = false,
    })
  end

  -- Scrollbar
  local scrollbar_ok, scrollbar = pcall(require, "scrollbar")
  if scrollbar_ok then
    scrollbar.setup({
      show = true,
      show_in_active_only = false,
      set_highlights = true,
      folds = 1000,
      max_lines = false,
      handle = {
        text = " ",
        color = nil,
        cterm = nil,
        highlight = "CursorColumn",
        hide_if_all_visible = true,
      },
      marks = {
        Search = {
          text = { "-", "=" },
          priority = 0,
          color = nil,
          cterm = nil,
          highlight = "Search",
        },
        Error = {
          text = { "-", "=" },
          priority = 1,
          color = nil,
          cterm = nil,
          highlight = "DiagnosticVirtualTextError",
        },
        Warn = {
          text = { "-", "=" },
          priority = 2,
          color = nil,
          cterm = nil,
          highlight = "DiagnosticVirtualTextWarn",
        },
        Info = {
          text = { "-", "=" },
          priority = 3,
          color = nil,
          cterm = nil,
          highlight = "DiagnosticVirtualTextInfo",
        },
        Hint = {
          text = { "-", "=" },
          priority = 4,
          color = nil,
          cterm = nil,
          highlight = "DiagnosticVirtualTextHint",
        },
        Misc = {
          text = { "-", "=" },
          priority = 5,
          color = nil,
          cterm = nil,
          highlight = "Normal",
        },
      },
      excluded_buftypes = {
        "terminal",
      },
      excluded_filetypes = {
        "prompt",
        "TelescopePrompt",
        "noice",
      },
      autocmd = {
        render = {
          "BufWinEnter",
          "TabEnter",
          "TermEnter",
          "WinEnter",
          "CmdwinLeave",
          "TextChanged",
          "VimResized",
          "WinScrolled",
        },
        clear = {
          "BufWinLeave",
          "TabLeave",
          "TermLeave",
          "WinLeave",
        },
      },
      handlers = {
        diagnostic = true,
        search = false,
      },
    })
  end
end

return M