local status, null_ls = pcall(require, "null-ls")
if (not status) then
  print("null-ls is not installed")
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
null_ls.setup {
  sources = {
    -- null_ls.builtins.formatting.codespell,
    null_ls.builtins.diagnostics.jsonlint,
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.proselint,
    null_ls.builtins.diagnostics.markdownlint,
    -- null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.diagnostics.sqlfluff.with({
        extra_args = { "--dialect", "hive" }, -- change to your dialect
    }),
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.cbfmt,
    -- tex
    null_ls.builtins.diagnostics.chktex,
    null_ls.builtins.formatting.latexindent
  }
}
local opts = { noremap = true, silent = true}
vim.keymap.set('n', '<leader>lf', '<cmd> lua vim.lsp.buf.format{ async = true }<CR>', opts)

