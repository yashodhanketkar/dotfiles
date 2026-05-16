-- startup programs
hl.on("hyprland.start", function()
	hl.exec_cmd("waybar")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("wl-paste --watch cliphist store")
	-- hl.exec_cmd("awww-daemon")

	hl.exec_cmd("firefox") -- personal preference to load on startup
end)
