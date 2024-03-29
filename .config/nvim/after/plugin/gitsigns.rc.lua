local status, gitsigns = pcall(require, "gitsigns")
if (not status) then
  print("gitsigns is not installed")
  return
end

gitsigns.setup {
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 200,
    ignore_whitespace = false,
  },

}
