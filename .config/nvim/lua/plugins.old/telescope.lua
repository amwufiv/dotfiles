-- Telescope fuzzy finder configuration
local M = {}

M.plugins = {
  {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  },
  "nvim-telescope/telescope-file-browser.nvim",
  {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
  "nvim-telescope/telescope-live-grep-args.nvim",
}

M.config = function()
  local telescope_ok, telescope = pcall(require, "telescope")
  if not telescope_ok then
    return
  end

  local actions_ok, actions = pcall(require, "telescope.actions")
  if not actions_ok then
    return
  end

  telescope.setup({
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      path_display = { "truncate" },
      file_ignore_patterns = { ".git/", "node_modules" },
      
      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-c>"] = actions.close,
          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,
          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,
          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,
          ["<PageUp>"] = actions.results_scrolling_up,
          ["<PageDown>"] = actions.results_scrolling_down,
          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          ["<C-l>"] = actions.complete_tag,
          ["<C-_>"] = actions.which_key,
        },
        n = {
          ["<esc>"] = actions.close,
          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,
          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["H"] = actions.move_to_top,
          ["M"] = actions.move_to_middle,
          ["L"] = actions.move_to_bottom,
          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,
          ["gg"] = actions.move_to_top,
          ["G"] = actions.move_to_bottom,
          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,
          ["<PageUp>"] = actions.results_scrolling_up,
          ["<PageDown>"] = actions.results_scrolling_down,
          ["?"] = actions.which_key,
        },
      },
    },
    pickers = {
      find_files = {
        theme = "dropdown",
        previewer = false,
        hidden = true,
      },
      live_grep = {
        theme = "dropdown",
        previewer = true,
      },
      grep_string = {
        theme = "dropdown",
        previewer = true,
      },
      buffers = {
        theme = "dropdown",
        previewer = false,
        initial_mode = "normal",
        mappings = {
          i = {
            ["<C-d>"] = actions.delete_buffer,
          },
          n = {
            ["dd"] = actions.delete_buffer,
          },
        },
      },
      planets = {
        show_pluto = true,
        show_moon = true,
      },
      colorscheme = {
        enable_preview = true,
      },
      lsp_references = {
        theme = "dropdown",
        initial_mode = "normal",
      },
      lsp_definitions = {
        theme = "dropdown",
        initial_mode = "normal",
      },
      lsp_declarations = {
        theme = "dropdown",
        initial_mode = "normal",
      },
      lsp_implementations = {
        theme = "dropdown",
        initial_mode = "normal",
      },
    },
    extensions = {
      file_browser = {
        theme = "dropdown",
        hijack_netrw = true,
        mappings = {
          ["i"] = {},
          ["n"] = {},
        },
      },
    },
  })

  -- Load extensions
  pcall(telescope.load_extension, "fzf")
  pcall(telescope.load_extension, "file_browser")
  pcall(telescope.load_extension, "live_grep_args")

  -- Keymaps
  local keymap = vim.keymap
  keymap.set("n", "<leader>ff", ":Telescope find_files<cr>")
  keymap.set("n", "<leader>fg", ":Telescope live_grep<cr>")
  keymap.set("n", "<leader>fb", ":Telescope buffers<cr>")
  keymap.set("n", "<leader>fh", ":Telescope help_tags<cr>")
  keymap.set("n", "<leader>fr", ":Telescope oldfiles<cr>")
  keymap.set("n", "<leader>fc", ":Telescope colorscheme<cr>")
  keymap.set("n", "<leader>fm", ":Telescope marks<cr>")
  keymap.set("n", "<leader>fp", ":Telescope file_browser<cr>")
end

return M