-- Neovim Configuration Entry Point
-- Clean, modular architecture with zero special cases

-- Load core configuration (no plugin dependencies)
require("core")

-- Load plugin system and configurations
require('config.lazy')