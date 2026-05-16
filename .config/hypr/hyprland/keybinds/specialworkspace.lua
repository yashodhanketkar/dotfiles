local utils = require("hyprland.utils")

---@param run_check_cmd string
---@param startup_cmd string
---@param wokspace_name string
local function handle_special_workspaces(run_check_cmd, startup_cmd, wokspace_name)
  -- stylua: ignore start
	local handle = io.popen(run_check_cmd)
  if handle == nil then return end

	local count = handle:read("*a")
	handle:close()
	-- stylua: ignore end

	if count == "" then
		hl.dispatch(hl.dsp.exec_cmd(startup_cmd))
	else
		hl.dispatch(hl.dsp.workspace.toggle_special(wokspace_name))
	end
end

---@class SpecialWorkspaceKeybind
---@field keys string
---@field run_check_cmd string
---@field startup_cmd string
---@field wokspace_name string
---@field desc string

---@type SpecialWorkspaceKeybind[]
local key_binds = {
	-- special workspaces apps
	{
		keys = "SUPER + S",
		desc = "Spotify",
		run_check_cmd = "pgrep -x spotify",
		startup_cmd = "spotify-launcher",
		wokspace_name = "Spotify",
	},
	{
		keys = "SUPER + C",
		cmd = "pgrep gnome-calculato && hyprctl dispatch togglespecialworkspace Calculator || gnome-calculator",
		desc = "Calculator",
		run_check_cmd = "pgrep -x gnome-calculato",
		startup_cmd = "gnome-calculator",
		wokspace_name = "Calculator",
	},
	{
		keys = "SUPER + G",
		cmd = "pgrep steam && hyprctl dispatch togglespecialworkspace Steam || steam -vgui -udp",
		desc = "Steam",
		run_check_cmd = "pgrep -x steam",
		startup_cmd = "steam -vgui -udp",
		wokspace_name = "Steam",
	},
}

for _, i in pairs(key_binds) do
	hl.bind(i.keys, function()
		handle_special_workspaces(i.run_check_cmd, i.startup_cmd, i.wokspace_name)
	end, { description = i.desc })
end
