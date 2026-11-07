-- ===========================================================================
-- PHYSICAL MONITOR CHANNELS & WORKSPACES MAPS
-- ===========================================================================

local utils = require("hyprland.utils")

-- ===========================================================================
-- 1. HARDWARE VIEWPORT ROUTING
-- ===========================================================================

-- === PRIMARY MONITOR ===
hl.monitor({
	output = utils.INTERNAL_DISPLAY,
	mode = "preferred",
	position = "auto-left",
	scale = 1,
	transform = 0,
})

-- === EXTERNAL MONITOR ===
hl.monitor({
	output = utils.EXTERNAL_DISPLAY,
	mode = "preferred",
	position = "auto-right",
	scale = 1,
	supports_hdr = false,
	cm = "srgb",
	sdr_eotf = "srgb",
})

-- === WORKSPACES BINDINGS ===
for _, i in pairs({
	{ name = "1", monitor = "eDP-1" },
	{ name = "2", monitor = "HDMI-A-1" },
	{ name = "3", monitor = "HDMI-A-1" },
	{ name = "10", monitor = "eDP-1" },
}) do
	hl.workspace_rule({
		workspace = i.name,
		monitor = i.monitor,
	})
end

-- ===========================================================================
-- 1. DISPLAY MODIFIERS
-- ===========================================================================

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

--- === MONITOR DISPLAY ROTATION MODIFIER ===
hl.bind("SUPER + J", utils.transform_clockwise, { description = "Rotate active/focused monitor clockwise" })
hl.bind("SUPER + K", utils.transform_anti_clockwise, { description = "Rotate active/focused monitor anticlockwise" })

-- === DISPLAY POWER STATE HANDLER ===
hl.bind("SUPER + SHIFT + M", dpms_toggle, { description = "Toggle DPMS state" })
