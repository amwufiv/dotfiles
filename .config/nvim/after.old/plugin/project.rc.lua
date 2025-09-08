local status, project = pcall(require, "project_nvim")
if (not status) then
  print("project_nvim is not install")
  return
end

project.setup {

}
