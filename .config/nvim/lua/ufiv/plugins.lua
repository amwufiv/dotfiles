local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  -- manage packer itself
  use 'wbthomason/packer.nvim'
  use {
  'nvim-lualine/lualine.nvim',
  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use 'nvim-lua/plenary.nvim' -- Common utilitie
  use 'onsails/lspkind-nvim'
  use 'hrsh7th/cmp-buffer' -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-nvim-lsp' -- nvim-cmp source for neovim's built-in LSP
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'hrsh7th/nvim-cmp' -- Completion
  use 'hrsh7th/cmp-omni'
  use 'hrsh7th/cmp-path'
  use 'saadparwaiz1/cmp_luasnip'


  use 'L3MON4D3/LuaSnip'
  use 'neovim/nvim-lspconfig' -- LSP
  use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua

  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'glepnir/lspsaga.nvim' -- LSP UI
  use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
  use 'nvim-treesitter/playground'
  use 'kyazdani42/nvim-web-devicons' -- File icon
  use 'windwp/nvim-autopairs'

  -- theme
  -- use "EdenEast/nightfox.nvim"
  use "rebelot/kanagawa.nvim"
  use "olimorris/onedarkpro.nvim"


  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use "nvim-telescope/telescope-file-browser.nvim"
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use "nvim-telescope/telescope-live-grep-args.nvim"
  use 'lewis6991/gitsigns.nvim'
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    }
  }
  use "numToStr/Comment.nvim"
  use "ahmedkhalf/project.nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use "folke/which-key.nvim"
  use "RRethy/vim-illuminate"
  use "glepnir/dashboard-nvim"
  use "petertriho/nvim-scrollbar"
  use "Pocco81/auto-save.nvim"
  use "famiu/bufdelete.nvim"
  use "crusj/bookmarks.nvim"
  use "gbprod/yanky.nvim"
  use "kkharji/sqlite.lua"
  -- use "mg979/vim-visual-multi"
  use "tpope/vim-fugitive"
  use "akinsho/git-conflict.nvim"
  use "junegunn/vim-easy-align"
  use "mfussenegger/nvim-dap"
  use "rcarriga/nvim-dap-ui"
  use "mfussenegger/nvim-dap-python"
  use "chentoast/marks.nvim"
  use "lervag/vimtex"

  -- remote
  use {
    'chipsenkbeil/distant.nvim',
    branch = 'v0.2',
  }

  -- use "Exafunction/codeium.vim"
  -- github copilot
  use 'github/copilot.vim'
end)


