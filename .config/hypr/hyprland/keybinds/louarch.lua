local utils = require("hyprland.utils")

---@type KeyBinds[]
local key_binds = {
	-- audio devices
	{ keys = "XF86Tools", cmd = "louarch audio sink", desc = "Select output device" },
	{ keys = "SUPER + A", cmd = "louarch audio sink", desc = "Select output device" },
	{ keys = "SUPER + SHIFT + A", cmd = "louarch audio source", desc = "Select input device" },

	-- browser shortcuts
	{ keys = "ALT + S", cmd = "louarch browser search", desc = "Search" },
	{ keys = "ALT + O", cmd = "louarch browser browse", desc = "Browse" },

	-- handle toggle-able mode
	{ keys = "ALT + G", cmd = "louarch osmode game", desc = "Game mode" },
	{ keys = "ALT + M", cmd = "louarch osmode night", desc = "Night mode" },

	-- handle wallpapers
	{ keys = "SUPER + W", cmd = "louarch wallpaper select", desc = "Select wallpaper" },
	{ keys = "SUPER + SHIFT + W", cmd = "louarch wallpaper random", desc = "Select random wallpaper" },
	{ keys = "SUPER + I", cmd = "louarch config keybinds", desc = "Show keybinds" },
}

utils.apply_all(key_binds)
