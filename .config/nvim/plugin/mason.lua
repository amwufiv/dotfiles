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
    "texlab",
    "gopls"
  },
  automatic_installation = true
}
