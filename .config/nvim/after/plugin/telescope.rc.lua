local status, telescope = pcall(require, "telescope")
if (not status) then
  print("telescope is not installed")
  return
end
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local fb_actioins = telescope.extensions.file_browser.actions
local lga_actions = require("telescope-live-grep-args.actions")

telescope.setup {
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close,
        ['<c-D>'] = actions.delete_buffer
      },
      i = {
        ['<c-D>'] = actions.delete_buffer
      }
    }
  },
  extensions = {
    file_browser = {
      theme = "dropdown",
      hijack_netrw = true,

    },
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    yank_history = {

    },
    live_grep_args = {
      auto_quoting = true,
      mappings = { -- extend mappings
        i = {
          ["C-k>"] = lga_actions.quote_prompt(),
          ["<C-g>"] = lga_actions.quote_prompt({ postfix = " -g " }),
        },
      },
    }
  }
}

telescope.load_extension("file_browser")
telescope.load_extension("projects")
telescope.load_extension("fzf")
telescope.load_extension("yank_history")
telescope.load_extension("live_grep_args")

local opts = { noremap = true }
vim.keymap.set('n', '<leader>ff', builtin.find_files, opts)
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, opts)
vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, opts)

vim.keymap.set('n', '<leader>fy', "<cmd>:Telescope yank_history<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
vim.keymap.set('n', '<leader>fp', ":Telescope projects<CR>", opts)
vim.keymap.set("n", "<leader>fq", builtin.quickfixhistory, opts)
vim.keymap.set("n", "<leader>fl", builtin.loclist, opts)
vim.keymap.set("n", "<leader>ft", builtin.treesitter, opts)
