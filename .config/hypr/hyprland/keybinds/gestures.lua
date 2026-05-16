-- Gestures with 3 fingers
-- focus related
hl.gesture({ fingers = 3, direction = "horizontal", scale = 1, action = "workspace" })
hl.gesture({
	fingers = 3,
	direction = "pinch",
	---@diagnostic disable-next-line: assign-type-mismatch
	action = function() -- handles fullscreen scaling issue
		hl.dispatch(hl.dsp.window.fullscreen())
	end,
})

-- volume related
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

-- Gestures with 4 fingers
hl.gesture({ fingers = 4, direction = "pinch", action = "resize" })
hl.gesture({ fingers = 4, direction = "vertical", mods = "SUPER", action = "float" })
hl.gesture({ fingers = 4, direction = "vertical", mods = "ALT", action = "move" })
hl.gesture({ fingers = 4, direction = "horizontal", mods = "ALT", action = "move" })
