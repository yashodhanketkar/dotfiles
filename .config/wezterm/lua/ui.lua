-- setup UI elements
local M = {}

local function setup_private(config)
	local ok, theme = pcall(require, "lua.private")
	if not ok then
		return
	else
		theme.apply_theme(config)
	end
end

function M.setup_ui(config)
	config.font_size = 14
	config.color_scheme = "Dracula+"
	config.max_fps = 240
	config.enable_scroll_bar = false
	config.window_background_opacity = 0.8
	config.hide_tab_bar_if_only_one_tab = true
	setup_private(config)
end

return M
