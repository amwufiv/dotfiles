local status,dapgo = pcall(require, 'dap-go')
if not status then
  print("dap-go is not installed")
end

dapgo.setup {

}
local opts = {noremap = true}
vim.keymap.set('n','<leader>db', ':DapToggleBreakpoint<CR>',opts)
vim.keymap.set('n','<leader>dus',
  function ()
    local widget = require('dap.ui.widgets')
    local sidebar = widget.sidebar(widget.scopes)
    sidebar.open()
  end, opts)
vim.keymap.set('n','<leader>dt',
  function ()
    require('dap-go').debug_test()
  end, opts)
vim.keymap.set('n','<leader>dl',
  function ()
    dapgo.debug_last_test()
  end, opts)
