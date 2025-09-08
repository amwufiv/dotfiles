-- Python specific configuration
local M = {}

M.plugins = {
  "mfussenegger/nvim-dap",
  "rcarriga/nvim-dap-ui",
  "mfussenegger/nvim-dap-python",
}

M.config = function()
  -- DAP Python
  local dap_python_ok, dap_python = pcall(require, "dap-python")
  if dap_python_ok then
    dap_python.setup("/usr/local/bin/python3")
  end

  -- DAP UI
  local dap_ui_ok, dap_ui = pcall(require, "dapui")
  if dap_ui_ok then
    dap_ui.setup({
      icons = { expanded = "▾", collapsed = "▸" },
      mappings = {
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      expand_lines = vim.fn.has("nvim-0.7"),
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.25 },
            "breakpoints",
            "stacks",
            "watches",
          },
          size = 40,
          position = "left",
        },
        {
          elements = {
            "repl",
            "console",
          },
          size = 0.25,
          position = "bottom",
        },
      },
      floating = {
        max_height = nil,
        max_width = nil,
        border = "single",
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      windows = { indent = 1 },
      render = {
        max_type_length = nil,
      },
    })
  end

  -- DAP
  local dap_ok, dap = pcall(require, "dap")
  if dap_ok then
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dap_ui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dap_ui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dap_ui.close()
    end

    -- Keymaps
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
    vim.keymap.set("n", "<leader>dc", dap.continue)
    vim.keymap.set("n", "<leader>di", dap.step_into)
    vim.keymap.set("n", "<leader>do", dap.step_over)
    vim.keymap.set("n", "<leader>dO", dap.step_out)
    vim.keymap.set("n", "<leader>dr", dap.repl.toggle)
    vim.keymap.set("n", "<leader>dl", dap.run_last)
    vim.keymap.set("n", "<leader>du", dap_ui.toggle)
    vim.keymap.set("n", "<leader>dt", dap.terminate)
  end
end

return M