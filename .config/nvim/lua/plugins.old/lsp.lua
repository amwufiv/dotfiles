-- LSP ecosystem configuration
local M = {}

M.plugins = {
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim", 
  "williamboman/mason-lspconfig.nvim",
  "jose-elias-alvarez/null-ls.nvim",
  "glepnir/lspsaga.nvim",
  "onsails/lspkind-nvim",
}

M.config = function()
  -- Mason setup
  local mason_ok, mason = pcall(require, "mason")
  if mason_ok then
    mason.setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    })
  end

  local mason_lsp_ok, mason_lsp = pcall(require, "mason-lspconfig")
  if mason_lsp_ok then
    mason_lsp.setup({
      automatic_installation = true
    })
  end

  -- LSP Config
  local lsp_ok, lspconfig = pcall(require, "lspconfig")
  if not lsp_ok then
    return
  end

  -- Capabilities
  local cmp_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp") 
  local capabilities = cmp_ok and cmp_lsp.default_capabilities() or vim.lsp.protocol.make_client_capabilities()

  -- LSP servers
  local servers = {
    pyright = {
      settings = {
        python = {
          analysis = {
            extraPaths = {
              '/Users/ufiv/code/tencent/qq-dw',
              '/Users/ufiv/code/tencent/qq-dw/ufiv/util'
            }
          }
        }
      }
    },
    lua_ls = {
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          diagnostics = { globals = {'vim'} },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = { enable = false },
        },
      },
    },
    jsonls = {},
    marksman = {},
  }

  -- Setup servers
  for server, config in pairs(servers) do
    config.capabilities = capabilities
    lspconfig[server].setup(config)
  end

  -- LSPSaga
  local saga_ok, saga = pcall(require, "lspsaga")
  if saga_ok then
    saga.init_lsp_saga()
  end

  -- Null-ls
  local null_ls_ok, null_ls = pcall(require, "null-ls")
  if null_ls_ok then
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.stylua,
      }
    })
  end

  -- LSP Keymaps
  local on_attach = function(client, bufnr)
    local keymap = vim.keymap
    local opts = { buffer = bufnr, silent = true }
    
    keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    keymap.set("n", "gr", vim.lsp.buf.references, opts)
    keymap.set("n", "K", vim.lsp.buf.hover, opts)
    keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  end

  -- Apply on_attach to all servers  
  local orig_setup = lspconfig.util.default_config
  orig_setup.on_attach = on_attach
end

return M