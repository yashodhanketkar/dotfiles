local M = {}

M.shadow = {
	enabled = true,
	range = 4,
	render_power = 3,
	color = "rgba(1a1a1aee)",
}

M.blur = {
	enabled = true,
	passes = 1,
	size = 3,
	vibrancy = 0.1696,
}

M.decoration = {
	rounding = 5,
	rounding_power = 2,

	shadow = M.shadow,
	blur = M.blur,
}

return M
