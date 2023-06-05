local status, bm = pcall(require, "bookmarks")
if not status then
  print("bookmarks is not installed")
  return
end

bm.setup{
  keymap = {
		toggle = "<leader>bbt", -- Toggle bookmarks
		add = "<leader>bba", -- Add bookmarks
		jump = "<CR>", -- Jump from bookmarks
		delete = "<leader>bbd", -- Delete bookmarks
		order = "<leader>bbo", -- Order bookmarks by frequency or updated_time
		delete_on_virt = "\\dd", -- Delete bookmark at virt text line
        show_desc = "<leader>bbs", -- show bookmark desc
	},
    width = 0.8, -- Bookmarks window width:  (0, 1]
    height = 0.6, -- Bookmarks window height: (0, 1]
    preview_ratio = 0.4, -- Bookmarks preview window ratio (0, 1]
    preview_ext_enable = false, -- If true, preview buf will add file ext, preview window may be highlighed(treesitter), but may be slower.
    fix_enable = true, -- If true, when saving the current file, if the bookmark line number of the current file changes, try to fix it.
    hl_cursorline = "guibg=Gray guifg=White", -- hl bookmarsk window cursorline.

    virt_text = "💫", -- Show virt text at the end of bookmarked lines
    virt_pattern = { "*.go", "*.lua", "*.sh", "*.php", "*.rust" } -- Show virt text only on matched pattern
}
