-- ===========================================================================
-- MULTI-TOUCH GESTURES
-- ===========================================================================

-- ===========================================================================
-- 1. THREE-FINGER GESTURES
-- ===========================================================================

-- === WINDOW FOCUS & LAYOUT ARCHITECTURE ===
hl.gesture({ fingers = 3, direction = "horizontal", scale = 1, action = "workspace" })
hl.gesture({
	fingers = 3,
	direction = "pinch",
	---@diagnostic disable-next-line: assign-type-mismatch
	action = function() -- handles fullscreen scaling issue
		hl.dispatch(hl.dsp.window.fullscreen())
	end,
})

-- === AUDIO VOLUME HARDWARE OVERRIDES ===
hl.gesture({
	fingers = 3,
	direction = "up",
	---@diagnostic disable-next-line: assign-type-mismatch
	action = function()
		hl.dispatch(hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"))
	end,
})
hl.gesture({
	fingers = 3,
	direction = "down",
	---@diagnostic disable-next-line: assign-type-mismatch
	action = function()
		hl.dispatch(hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"))
	end,
})

-- === BACKLIGHT BRIGHTNESS HARDWARE OVERRIDES ===
hl.gesture({
	fingers = 3,
	direction = "down",
	mods = "ALT",
	---@diagnostic disable-next-line: assign-type-mismatch
	action = function()
		hl.dispatch(hl.dsp.exec_cmd("brightnessctl set 5%-"))
	end,
})
hl.gesture({
	fingers = 3,
	direction = "up",
	mods = "ALT",
	---@diagnostic disable-next-line: assign-type-mismatch
	action = function()
		hl.dispatch(hl.dsp.exec_cmd("brightnessctl set +5%"))
	end,
})

-- ===========================================================================
-- 2. FOUR-FINGER GESTURES
-- ===========================================================================

hl.gesture({ fingers = 4, direction = "pinch", action = "resize" })
hl.gesture({ fingers = 4, direction = "vertical", mods = "SUPER", action = "float" })
hl.gesture({ fingers = 4, direction = "vertical", mods = "ALT", action = "move" })
hl.gesture({ fingers = 4, direction = "horizontal", mods = "ALT", action = "move" })
