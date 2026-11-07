-- ===========================================================================
-- STARTUP CONFIGURATION
-- ===========================================================================

hl.on("hyprland.start", function()
	-- === STARTUP SERVICES ===
	hl.exec_cmd("waybar")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("wl-paste --watch cliphist store")
	hl.exec_cmd("~/.config/hypr/scripts/hyprlock-running.sh")
	-- hl.exec_cmd("awww-daemon")

	-- === STARTUP PROGRAMS ===
	hl.exec_cmd("firefox")
end)
