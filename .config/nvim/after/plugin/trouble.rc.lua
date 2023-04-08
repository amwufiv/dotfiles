local status, trouble = pcall(require, "trouble")
if not status then
  print("trouble is not installed")
  return
end

trouble.setup{
  mode = "quickfix"
}
