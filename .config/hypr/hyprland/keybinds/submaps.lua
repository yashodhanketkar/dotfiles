hl.bind("SUPER + R", hl.dsp.submap("resize"), {
	description = "Enter resize mode",
})

hl.define_submap("resize", function()
	-- small increments
	hl.bind(
		"L",
		hl.dsp.window.resize({ x = 10, y = 0, relative = true }),
		{ repeating = true, description = "Increase width by 10" }
	)
	hl.bind(
		"H",
		hl.dsp.window.resize({ x = -10, y = 0, relative = true }),
		{ repeating = true, description = "Decrease width by 10" }
	)
	hl.bind(
		"K",
		hl.dsp.window.resize({ x = 0, y = 10, relative = true }),
		{ repeating = true, description = "Increase height by 10" }
	)
	hl.bind(
		"J",
		hl.dsp.window.resize({ x = 0, y = -10, relative = true }),
		{ repeating = true, description = "Decrease height by 10" }
	)

	-- large increments
	hl.bind(
		"SHIFT + L",
		hl.dsp.window.resize({ x = 50, y = 0, relative = true }),
		{ repeating = true, description = "Increase width by 50" }
	)
	hl.bind(
		"SHIFT + H",
		hl.dsp.window.resize({ x = -50, y = 0, relative = true }),
		{ repeating = true, description = "Decrease width by 50" }
	)
	hl.bind(
		"SHIFT + K",
		hl.dsp.window.resize({ x = 0, y = 50, relative = true }),
		{ repeating = true, description = "Increase height by 50" }
	)
	hl.bind(
		"SHIFT + J",
		hl.dsp.window.resize({ x = 0, y = -50, relative = true }),
		{ repeating = true, description = "Decrease height by 50" }
	)

	hl.bind("ESCAPE", hl.dsp.submap("reset"), {
		description = "Exit resize mode",
	})
end)

hl.bind("SUPER + T", hl.dsp.submap("trading"), {
	description = "Enter trading mode",
})
hl.define_submap("trading", function()
	hl.unbind("H")
	hl.unbind("J")
	hl.unbind("K")
	hl.unbind("L")

	hl.bind("SUPER + ESCAPE", hl.dsp.submap("reset"), {
		description = "Exit trading mode",
	})
end)
