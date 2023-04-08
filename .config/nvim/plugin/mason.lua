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
    "sumneko_lua",
    "texlab",
  },
  automatic_installation = true
}
