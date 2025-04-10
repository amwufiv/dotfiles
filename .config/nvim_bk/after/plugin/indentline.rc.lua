local status, indent_blankline = pcall(require, "indent_blankline")
if (not status) then
  print("indent_blankline is not installed")
  return
end

-- see help doc: :help indent_blankline.txt

indent_blankline.setup {
  show_current_context = true,
  show_current_context_start = true,
  show_current_context_start_on_current_line = false,
  -- use_treesitter_scope = true,
  context_char = "▏",
  char = "",--"▏",
  show_trailing_blankline_indent = false,
  space_char_blankline = " ",
  filetype_exclude = {
    "dashboard",
    "help",
    "NvimTree",
    "lspinfo",
    "packer",
    "checkhealth",
    "man",
    "",
  },
  use_treesitter = true,




}
