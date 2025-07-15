local wezterm = require("wezterm")
local config = wezterm.config_builder()

require("lua.ui").setup_ui(config)
require("lua.configs").setup_configs(config)

return config
