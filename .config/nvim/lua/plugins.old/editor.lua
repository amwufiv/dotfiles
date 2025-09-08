-- Editor enhancement plugins
local M = {}

M.plugins = {
  {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  },
  'nvim-treesitter/playground',
  'windwp/nvim-autopairs',
  "numToStr/Comment.nvim",
  'RRethy/vim-illuminate',
  "folke/which-key.nvim",
  "Pocco81/auto-save.nvim",
  "chentoast/marks.nvim",
  "gbprod/yanky.nvim",
  "crusj/bookmarks.nvim",
  "kkharji/sqlite.lua",
  {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    }
  },
}

M.config = function()
  -- Treesitter
  local ts_ok, treesitter = pcall(require, "nvim-treesitter.configs")
  if ts_ok then
    treesitter.setup({
      ensure_installed = {
        "bash",
        "c", 
        "cpp",
        "css",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "python",
        "rust",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
      sync_install = false,
      auto_install = true,
      ignore_install = {},
      modules = {},
      highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
        disable = {},
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn", 
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
    })
  end

  -- Autopairs
  local autopairs_ok, autopairs = pcall(require, "nvim-autopairs")
  if autopairs_ok then
    autopairs.setup({
      check_ts = true,
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
      },
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = [=[[%'%"%)%>%]%)%}%,]]=],
        offset = 0,
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
    })
  end

  -- Comment
  local comment_ok, comment = pcall(require, "Comment")
  if comment_ok then
    comment.setup({
      padding = true,
      sticky = true,
      ignore = nil,
      toggler = {
        line = "gcc",
        block = "gbc",
      },
      opleader = {
        line = "gc",
        block = "gb",
      },
      extra = {
        above = "gcO",
        below = "gco",
        eol = "gcA",
      },
      mappings = {
        basic = true,
        extra = true,
      },
      pre_hook = nil,
      post_hook = nil,
    })
  end

  -- Which Key
  local whichkey_ok, whichkey = pcall(require, "which-key")
  if whichkey_ok then
    whichkey.setup({
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = true,
          motions = true,
          text_objects = true,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },
      key_labels = {},
      icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
      },
      popup_mappings = {
        scroll_down = "<c-d>",
        scroll_up = "<c-u>",
      },
      window = {
        border = "rounded",
        position = "bottom",
        margin = { 1, 0, 1, 0 },
        padding = { 2, 2, 2, 2 },
        winblend = 0,
      },
      layout = {
        height = { min = 4, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = "left",
      },
      ignore_missing = false,
      hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
      show_help = true,
      triggers = "auto",
      triggers_blacklist = {
        i = { "j", "k" },
        v = { "j", "k" },
      },
    })
  end

  -- Auto save
  local autosave_ok, autosave = pcall(require, "auto-save")
  if autosave_ok then
    autosave.setup({
      enabled = true,
      execution_message = {
        message = function()
          return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
        end,
        dim = 0.18,
        cleaning_interval = 1250,
      },
      trigger_events = {"InsertLeave", "TextChanged"},
      condition = function(buf)
        local fn = vim.fn
        local utils = require("auto-save.utils.data")
        
        if fn.getbufvar(buf, "&modifiable") == 1 and
           utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
          return true
        end
        return false
      end,
      write_all_buffers = false,
      debounce_delay = 135,
      callbacks = {
        enabling = nil,
        disabling = nil,
        before_asserting_save = nil,
        before_saving = nil,
        after_saving = nil
      },
    })
  end

  -- Marks
  local marks_ok, marks = pcall(require, "marks")
  if marks_ok then
    marks.setup({
      default_mappings = true,
      builtin_marks = { ".", "<", ">", "^" },
      cyclic = true,
      force_write_shada = false,
      refresh_interval = 250,
      sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
      excluded_filetypes = {},
      bookmark_0 = {
        sign = "⚑",
        virt_text = "hello world",
        annotate = false,
      },
      mappings = {}
    })
  end

  -- Yanky
  local yanky_ok, yanky = pcall(require, "yanky")
  if yanky_ok then
    yanky.setup({
      ring = {
        history_length = 100,
        storage = "shada",
        sync_with_numbered_registers = true,
        cancel_event = "update",
      },
      picker = {
        select = {
          action = nil,
        },
        telescope = {
          mappings = nil,
        },
      },
      system_clipboard = {
        sync_with_ring = true,
      },
      highlight = {
        on_put = true,
        on_yank = true,
        timer = 500,
      },
      preserve_cursor_position = {
        enabled = true,
      },
    })
  end

  -- Bookmarks
  local bookmarks_ok, bookmarks = pcall(require, "bookmarks")
  if bookmarks_ok then
    bookmarks.setup({
      save_file = vim.fn.expand "$HOME/.bookmarks",
      keywords =  {
        ["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon
        ["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon
        ["@f"] = "⛏ ", -- mark annotation startswith @f ,signs this icon
        ["@n"] = " ", -- mark annotation startswith @n ,signs this icon
      },
      on_attach = function(bufnr)
        local bm = require "bookmarks"
        local map = vim.keymap.set
        map("n","mm",bm.bookmark_toggle) -- add or remove bookmark at current line
        map("n","mi",bm.bookmark_ann) -- add or edit mark annotation at current line
        map("n","mc",bm.bookmark_clean) -- clean all marks in local buffer
        map("n","mn",bm.bookmark_next) -- jump to next mark in local buffer
        map("n","mp",bm.bookmark_prev) -- jump to previous mark in local buffer
        map("n","ml",bm.bookmark_list) -- show marked file list in quickfix window
      end
    })
  end

  -- Nvim Tree
  local nvim_tree_ok, nvim_tree = pcall(require, "nvim-tree")
  if nvim_tree_ok then
    nvim_tree.setup({
      disable_netrw = true,
      hijack_netrw = true,
      open_on_tab = false,
      hijack_cursor = false,
      update_cwd = true,
      diagnostics = {
        enable = true,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
      },
      system_open = {
        cmd = nil,
        args = {},
      },
      filters = {
        dotfiles = false,
        custom = {},
      },
      git = {
        enable = true,
        ignore = true,
        timeout = 500,
      },
      view = {
        width = 30,
        side = "left",
      },
      trash = {
        cmd = "trash",
        require_confirm = true,
      },
      actions = {
        open_file = {
          quit_on_open = false,
          resize_window = false,
          window_picker = {
            enable = true,
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
      },
    })

    -- Keymaps for nvim-tree
    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<cr>", { silent = true })
  end
end

return M