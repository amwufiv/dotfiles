-- mason setup
local mason_status, mason = pcall(require, "mason")
if (mason_status) 
then
  mason.setup()
  local mason_lsp_status, mason_lsp = pcall(require, "mason_lspconfig")
  if(mason_lsp_status)
  then 
    lspconfig.setup {
        automatic_installation = true
    }
  end
end



local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then 
  print("lspconfig is not installed")
  return 
end

local protocol = require('vim.lsp.protocol')
protocol.CompletionItemKind = {
  '', -- Text
  '', -- Method
  '', -- Function
  '', -- Constructor
  '', -- Field
  '', -- Variable
  '', -- Class
  'ﰮ', -- Interface
  '', -- Module
  '', -- Property
  '', -- Unit
  '', -- Value
  '', -- Enum
  '', -- Keyword
  '﬌', -- Snippet
  '', -- Color
  '', -- File
  '', -- Reference
  '', -- Folder
  '', -- EnumMember
  '', -- Constant
  '', -- Struct
  '', -- Event
  'ﬦ', -- Operator
  '', -- TypeParameter
}

-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').default_capabilities()

nvim_lsp.pyright.setup{
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        extraPaths = {'/Users/ufiv/code/tencent/qq-dw',
        '/Users/ufiv/code/tencent/qq-dw/ufiv/util'}
      }
    }
  }
}

nvim_lsp.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}


nvim_lsp.jsonls.setup{
  capabilities = capabilities,
  
}

nvim_lsp.marksman.setup {
  capabilities = capabilities
}

-- https://github.com/latex-lsp/texlab/wiki/Configuration
-- nvim_lsp.texlab.setup {
--   capabilities = capabilities,
--   settings = {
--     texlab = {
--     auxDirectory = ".",
--     bibtexFormatter = "texlab",
--     build = {
--       args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
--       executable = "latexmk",
--       forwardSearchAfter = false,
--       onSave = false
--     },
--     chktex = {
--       onEdit = false,
--       onOpenAndSave = false
--     },
--     diagnosticsDelay = 300,
--     formatterLineLength = 80,
--     forwardSearch = {
--       args = {}
--     },
--     latexFormatter = "latexindent",
--     latexindent = {
--       modifyLineBreaks = false
--     }
--     }
--   }
-- }
