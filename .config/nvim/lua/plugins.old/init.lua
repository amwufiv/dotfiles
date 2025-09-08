-- Plugin management bootstrapper
-- Converts from packer to cleaner architecture

local function bootstrap_packer()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = bootstrap_packer()
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Plugin loader
local function load_plugin_module(module_name)
  local status_ok, module = pcall(require, "plugins." .. module_name)
  if not status_ok then
    vim.notify("Failed to load plugin module: " .. module_name, vim.log.levels.ERROR)
    return {}
  end
  
  return module.plugins or {}
end

-- Initialize packer
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

return packer.startup(function(use)
  -- Packer itself
  use("wbthomason/packer.nvim")
  
  -- Load plugin modules
  local plugin_modules = {
    "editor",
    "ui", 
    "lsp",
    "completion",
    "telescope",
    "git",
    "langs.python",
    "langs.tex",
  }
  
  for _, module_name in ipairs(plugin_modules) do
    local plugins = load_plugin_module(module_name)
    for _, plugin in ipairs(plugins) do
      use(plugin)
    end
  end
  
  if packer_bootstrap then
    require("packer").sync()
  end
end)