-- ===========================================================================
-- HYPRLAND SUBMAPS
-- ===========================================================================

-- ===========================================================================
-- 1. WINDOW RESIZE MODE
-- ===========================================================================

hl.bind("SUPER + R", hl.dsp.submap("resize"), { description = "Enter resize mode" })

hl.define_submap("resize", function()
	-- === SMALL INCREMENTS (HJKL KEYPAD) ===
  -- stylua: ignore start
	hl.bind("L", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true, description = "Increase width by 10" })
	hl.bind("H", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true, description = "Decrease width by 10" })
	hl.bind("K", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true, description = "Increase height by 10" })
	hl.bind("J", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true, description = "Decrease height by 10" })

	-- === LARGE INCREMENTS (SHIFT + HJKL KEYPAD) ===
	hl.bind("SHIFT + L", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true, description = "Increase width by 50" })
	hl.bind("SHIFT + H", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true, description = "Decrease width by 50" })
	hl.bind("SHIFT + K", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true, description = "Increase height by 50" })
	hl.bind("SHIFT + J", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true, description = "Decrease height by 50" })
	-- stylua: ignore end

	hl.bind("ESCAPE", hl.dsp.submap("reset"), { description = "Exit resize mode" })
end)

-- ===========================================================================
-- 2. FOCUSED TRADING MODE
-- ===========================================================================

hl.bind("SUPER + T", hl.dsp.submap("trading"), { description = "Enter trading mode" })

hl.define_submap("trading", function()
	-- UNBINDS DEFAULT MOVEMENT BINDS
	hl.unbind("H")
	hl.unbind("J")
	hl.unbind("K")
	hl.unbind("L")

	hl.bind("SUPER + ESCAPE", hl.dsp.submap("reset"), { description = "Exit trading mode" })
end)
