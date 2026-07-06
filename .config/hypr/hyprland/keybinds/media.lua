local utils = require("hyprland.utils")

---@type KeyBinds[]
local key_binds = {
	-- volume keys
	{ keys = "XF86AudioRaiseVolume", cmd = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+", desc = "Raise volume" },
	{ keys = "XF86AudioLowerVolume", cmd = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-", desc = "Raise volume" },
	{ keys = "XF86AudioMute", cmd = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle", desc = "Toggle speaker mute" },
	{ keys = "XF86AudioMicMute", cmd = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle", desc = "Toggle mic mute" },

	-- brightness keys
	{ keys = "XF86MonBrightnessUp", cmd = "brightnessctl set +5%", desc = "Increase brightness" },
	{ keys = "XF86MonBrightnessDown", cmd = "brightnessctl set 5%-", desc = "Decrease brightness" },

	-- media keys
	{ keys = "XF86AudioPlay", cmd = "playerctl play-pause", desc = "Play/Pause" },
	{ keys = "XF86AudioPause", cmd = "playerctl play-pause", desc = "Play/Pause" },
	{ keys = "XF86AudioNext", cmd = "playerctl next", desc = "Next track" },
	{ keys = "XF86AudioPrev", cmd = "playerctl previous", desc = "Previous track" },
	{ keys = "SHIFT + XF86AudioNext", cmd = "playerctl position 5+", desc = "Seek forward 5 seconds" },
	{ keys = "SHIFT + XF86AudioPrev", cmd = "playerctl position 5-", desc = "Seek backward 5 seconds" },
	{ keys = "XF86AudioStop", cmd = "playerctl stop", desc = "Stop" },
}

for _, i in pairs(key_binds) do
	hl.bind(i.keys, hl.dsp.exec_cmd(i.cmd), {
		description = i.desc,
		locked = true,
		repeating = true,
	})
end

-- stylua: ignore start
hl.bind("switch:on:Lid Switch", utils.handle_lid_close, { locked = true, description = "Turn of internal display or lock" })
hl.bind("switch:off:Lid Switch", utils.handle_lid_open, { locked = true, description = "Turn on internal display" })
-- stylua: ignore end
