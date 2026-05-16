local M = {}

M.input = {
	kb_layout = "us",

	follow_mouse = 1,
	sensitivity = 0,
	accel_profile = "flat",

	touchpad = {
		natural_scroll = true,
	},

	tablet = M.wacom,
}

M.wacom = {
	name = "wacom-one-by-wacom-s-pen",
	output = "HDMI-A-1",
}

return M
