local utils = require("hyprland.utils")

--- Handles workspace movements and focus
---
---@param key string
---@param dir string
---@param target string
local function movements(key, dir, target)
	hl.bind("ALT + " .. key, hl.dsp.focus({ [target] = dir }), { description = "Focus to " .. dir })
	hl.bind("ALT + SHIFT + " .. key, hl.dsp.window.move({ [target] = dir }), { description = "Move window to " .. dir })
  -- stylua: ignore start
	hl.bind("ALT + SHIFT + " .. key, hl.dsp.window.move({ [target] = dir }), { description = "Move window to " .. dir })
	hl.bind("ALT + CTRL + SHIFT + " .. key, hl.dsp.window.move({ [target] = dir, follow = false }), { description = "Move window to " .. dir .. " silently" })
	-- stylua: ignore end
end

--- Handles DPMS state
---
--- togle DPMS state based on current state
--- `enable` in case other misc config fails
local function dpms_toggle()
	local monitors = hl.get_monitors()
	local state = false -- default to off

	for _, monitor in ipairs(monitors) do
		if monitor.dpms_status == true then
			state = true
		end
	end

	-- handle offchance misfire due to key release
	hl.timer(function()
		hl.dispatch(hl.dsp.dpms({ action = state and "disable" or "enable" }))
	end, { timeout = 500, type = "oneshot" })
end

-- handle window focus and movement via hjkl keys
for _, i in pairs({
	{ dir = "left", key = "H" },
	{ dir = "down", key = "J" },
	{ dir = "up", key = "K" },
	{ dir = "right", key = "L" },
}) do
	movements(i.key, i.dir, "direction")
end

-- handle window focus and movement via 1-10 keys
for i = 1, 10 do
	local key = i % 10
	movements(tostring(key), tostring(i), "workspace")
end

-- window actions
hl.bind("ALT + F", hl.dsp.window.fullscreen(), { description = "Toggle Fullscreen" })
hl.bind("ALT + SHIFT + Q", hl.dsp.window.close(), { description = "Close Window" })
hl.bind("ALT + SHIFT + V", hl.dsp.window.float(), { description = "Toggle Float" })
hl.bind("ALT + SPACE", hl.dsp.layout("togglesplit"), { description = "Toggle Split" })

-- mouse handling
hl.bind("ALT + R", hl.dsp.window.resize(), { description = "Resize window" })
hl.bind("ALT + mouse:273", hl.dsp.window.resize(), { description = "Resize window" })
hl.bind("ALT + mouse:272", hl.dsp.window.drag(), { description = "Drag window" })
hl.bind("ALT + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = "Move window to next workspace" })
hl.bind("ALT + mouse_up", hl.dsp.focus({ workspace = "e-1" }), { description = "Move window to next workspace" })

--- Handles clockwise rotation of the active monitor
hl.bind("SUPER + J", utils.transform_clockwise, { description = "Rotate active/focused monitor clockwise" })
hl.bind("SUPER + K", utils.transform_anti_clockwise, { description = "Rotate active/focused monitor anticlockwise" })

-- dpms toggle
hl.bind("SUPER + SHIFT + M", dpms_toggle, { description = "Toggle DPMS state" })
