local status, marks = pcall(require, "marks")
if not status then
  print("marks is not installed")
  return
end

-- https://github.com/chentoast/marks.nvim
marks.setup{

}
