local status, comment = pcall(require, "Comment")
if (not status) then
  print("Comment is not installed")
  return
end

-- help: https://github.com/numToStr/Comment.nvim

comment.setup {}
