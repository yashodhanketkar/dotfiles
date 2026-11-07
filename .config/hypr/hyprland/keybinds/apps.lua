-- ===========================================================================
-- HYPRLAND KEYBINDINGS CONFIGURATION
-- ===========================================================================

local utils = require("hyprland.utils")

-- ===========================================================================
-- 1. DEFAULT APPLICATIONS & TARGET PATHS
-- ===========================================================================

local terminal = "wezterm"
local filemanager = "nautilus"
local scripts = "$HOME/.config/hypr/scripts/hyprscripts.sh"

local snapcmd = "hyprshot -o ~/Pictures/snaps"

-- ===========================================================================
-- 2. KEYBINDING REGISTERY
-- ===========================================================================

---@type KeyBinds[]
local key_binds = {
	-- === CORE SYSTEM LAUNCHER ===
	{ keys = "ALT + RETURN", cmd = terminal, desc = "Open " .. terminal },
	{ keys = "SUPER + E", cmd = filemanager, desc = "Open " .. filemanager },

	-- === WEB BROWSERS ===
	{ keys = "SUPER + F", cmd = "firefox", desc = "Launch firefox" },
	{ keys = "SUPER + B", cmd = "brave", desc = "Launch brave" },
	{ keys = "SUPER + SHIFT + F", cmd = "firefox -private-window", desc = "Launch private firefox" },
	{ keys = "SUPER + SHIFT + B", cmd = "chromium", desc = "Launch chromium" },

	-- === ROFI, SESSION MANAGEMENT & PANELS ===
	{ keys = "ALT + D", cmd = "pkill rofi || rofi -show drun", desc = "Open app launcher" },
	{ keys = "ALT + SHIFT + D", cmd = "pkill rofi || rofi -show window", desc = "Task switcher" },
	{ keys = "SUPER + V", cmd = "pkill rofi || " .. scripts .. " clipboard", desc = "Clipboard" },
	{ keys = "SUPER + L", cmd = "pidof hyprlock || hyprlock --immediate-render", desc = "Locks session" },
	{ keys = "SUPER + P", cmd = "pkill wlogout || wlogout", desc = "Logout" },
	{ keys = "SUPER + SHIFT + S", cmd = "localsend", desc = "Launch localsend" },
	{ keys = "SUPER + N", cmd = "swaync-client -t -sw", desc = "Open swaync panel" },

	-- === WAYBAR MANAGEMENT & QUICK NOTES ===
	{ keys = "ALT + TAB", cmd = "pkill -SIGUSR1 waybar", desc = "Send SIGUSR1 to waybar, toggle hide" },
	{ keys = "ALT + SHIFT + TAB", cmd = "pkill -SIGUSR2 waybar", desc = "Send SIGUSR2 to waybar, soft reset" },
	{ keys = "ALT + SHIFT + R", cmd = "killall -q waybar; waybar", desc = "Restart waybar, hard reset" },
	{ keys = "ALT + N", cmd = "wezterm start nvim $HOME/private/quicknotes.md", desc = "Open quicknotes" },

	-- === SCREENSHOT, UTILITES & WIDGETS ===
	{ keys = "PRINT", cmd = snapcmd .. " -m region", desc = "Snaps region" },
	{ keys = "ALT + PRINT", cmd = snapcmd .. " -m window", desc = "Snaps window" },
	{ keys = "SUPER + PRINT", cmd = snapcmd .. " -m output", desc = "Snaps workspace" },
	{ keys = "SUPER + SHIFT + PRINT", cmd = snapcmd .. " -m active -m output", desc = "Snaps active workspace" },
	{ keys = "ALT + P", cmd = "hyprpicker -a", desc = "Color picker" },
	{ keys = "ALT + SHIFT + S", cmd = scripts .. " get_special", desc = "Launch special apps" },
	{ keys = "SUPER + Q", cmd = "eww close-all", desc = "Killa all eww widgets" },
}

-- ===========================================================================
-- 3. INITIALIZATION
-- ===========================================================================

utils.apply_all(key_binds)
