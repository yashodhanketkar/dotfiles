hl.bind("SUPER + R", hl.dsp.submap("resize"))

hl.define_submap("resize", function()
	-- small increments
	hl.bind("L", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
	hl.bind("H", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
	hl.bind("K", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
	hl.bind("J", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })

	-- large increments
	hl.bind("SHIFT + L", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
	hl.bind("SHIFT + H", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
	hl.bind("SHIFT + K", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true })
	hl.bind("SHIFT + J", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })

	hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

hl.bind("SUPER + T", hl.dsp.submap("trading"))
hl.define_submap("trading", function()
	hl.unbind("H")
	hl.unbind("J")
	hl.unbind("K")
	hl.unbind("L")

	hl.bind("SUPER + ESCAPE", hl.dsp.submap("reset"))
end)
