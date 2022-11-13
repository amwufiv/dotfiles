local status, lualine = pcall(require, "lualine")
if (not status) then 
  print("lualine not installed")	
  return 
end

lualine.setup {
  icons_enabled = true,
  theme = 'wombat',
  section_separators = { left = '', right = '' }
}
