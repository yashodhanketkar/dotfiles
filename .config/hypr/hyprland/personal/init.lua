-- ===========================================================================
-- PERSONALIZED LOOK RELATED CONFIGURATIONS
-- ===========================================================================

require("hyprland.personal.static.animations")
require("hyprland.personal.static.rules")

local colors = require("hyprland.personal.dynamic.colors")
local decoration = require("hyprland.personal.static.decorations").decoration
local input = require("hyprland.personal.static.devices").input

hl.config({
	general = {
		gaps_in = 2,
		gaps_out = 5,
		border_size = 2,
		allow_tearing = false,
		layout = "dwindle",
		col = {
			active_border = colors.gradActive,
			inactive_border = colors.gradInactive,
		},
	},

	dwindle = {
		preserve_split = true,
	},

	scrolling = {
		focus_fit_method = true,
		direction = "right",
		column_width = 0.5,
	},

	misc = {
		force_default_wallpaper = -1,
		disable_hyprland_logo = false,
		allow_session_lock_restore = true,

		animate_manual_resizes = true,
		animate_mouse_windowdragging = true,

		mouse_move_enables_dpms = true,
		key_press_enables_dpms = true,
	},

	cursor = {
		persistent_warps = true,
		no_hardware_cursors = 0,
	},

	decoration = decoration,
	input = input,
})
