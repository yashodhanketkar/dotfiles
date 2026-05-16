require("hyprland.personal.looks")
require("hyprland.personal.animations")

local colors = require("hyprland.personal.colors")

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
	},

	cursor = {
		persistent_warps = true,
	},

	decoration = require("hyprland.personal.decorations").decoration,
	input = require("hyprland.personal.devices").input,
})
