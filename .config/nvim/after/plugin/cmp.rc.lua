local status, cmp = pcall(require, "cmp")
if (not status) then
  return
end
local lspkind = require 'lspkind'


cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  sources = {
    {
      name = 'nvim_lsp'
    },
    {
      name = 'nvim_lsp_signature_help'
    },
    {
      name = 'luasnip'
    },
    {
      name = 'buffer',
      option = {
        -- Options go into this table
      },
    },
    {
      name = 'path'
    },
    {
      name = 'omni',
      
    }
  },

  mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
  formatting = {
    format = lspkind.cmp_format({ with_text = false, maxwidth = 50 })
  }
})

vim.cmd [[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]]


