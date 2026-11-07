-- ===========================================================================
-- LOUARCH WRAPPER INTEGRATIONS
-- ===========================================================================

local utils = require("hyprland.utils")

-- ===========================================================================
-- 1. KEYBINDING REGISTRY
-- ===========================================================================

---@type KeyBinds[]
local key_binds = {
	-- === AUDIO DRIVER HANDLERS/ROTUER ===
	{ keys = "XF86Tools", cmd = "louarch audio sink", desc = "Select output device" },
	{ keys = "SUPER + A", cmd = "louarch audio sink", desc = "Select output device" },
	{ keys = "SUPER + SHIFT + A", cmd = "louarch audio source", desc = "Select input device" },

	-- === WEB BROWSER SHORTCUT ===
	{ keys = "ALT + S", cmd = "louarch browser search", desc = "Search" },
	{ keys = "ALT + O", cmd = "louarch browser browse", desc = "Browse" },

	-- === OS SPECIFIC MODE TOGGLER ===
	{ keys = "ALT + G", cmd = "louarch osmode game", desc = "Game mode" },
	{ keys = "ALT + M", cmd = "louarch osmode night", desc = "Night mode" },

	-- === WALLPAPERS HANDLERS ===
	{ keys = "SUPER + W", cmd = "louarch wallpaper select", desc = "Select wallpaper" },
	{ keys = "SUPER + SHIFT + W", cmd = "louarch wallpaper random", desc = "Select random wallpaper" },
	{ keys = "SUPER + I", cmd = "louarch config keybinds", desc = "Show keybinds" },
}

-- ===========================================================================
-- 2. INITIALIZATION
-- ===========================================================================
utils.apply_all(key_binds)
