local mason_status, mason = pcall(require, "mason")
if not mason_status then
  print("mason is not installed")
  return
end

local status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status then
  print("mason-lspconfig is not installed")
  return
end

mason_lspconfig.setup{
  ensure_installed = {
    "jsonls",
    "marksman",
    "pyright",
    "lua_ls",
  },
  automatic_installation = true
}
