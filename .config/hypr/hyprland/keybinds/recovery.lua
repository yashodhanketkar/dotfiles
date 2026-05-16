--- Wraps dispatch command to be used in keybinds
---
---@param cmd string
local function dispatch_wrapper(cmd)
	hl.dispatch(hl.dsp.exec_cmd(cmd))
end

local function handle_lock_reovery()
	dispatch_wrapper("hyprctl notify 1 2000 0 'oopsies'")
	dispatch_wrapper("hyprctl --instance 0 dispatch exec killall hyprlock dms")
	os.execute("sleep 0.2")

	dispatch_wrapper("misc:allow_session_lock_restore 1")
	os.execute("sleep 0.2")

	dispatch_wrapper("hyprlock")
	os.execute("sleep 0.2")

	dispatch_wrapper("misc:allow_session_lock_restore 0")
end

hl.bind(
	"CTRL + ALT + L",
	handle_lock_reovery,
	{ locked = true, description = "Forcefully kill hyprlock and starts it again" }
)
