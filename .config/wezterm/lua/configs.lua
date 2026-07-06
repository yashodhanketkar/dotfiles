local M = {}

---@param config Config
function M.setup_configs(config)
	config.enable_wayland = false
	config.warn_about_missing_glyphs = false
end

return M
