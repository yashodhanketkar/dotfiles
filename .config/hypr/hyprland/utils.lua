local M = {}

--- Internal display
--- eDP-1 - Dedicated Graphics Card (Nvidia)
--- eDP-2 - Hybrid Mode (Nvidia + AMD)
M.INTERNAL_DISPLAY = "eDP-1"

---@class KeyBinds
---
---@field keys string key sequence to run command
---@field cmd string command to run
---@field desc string description of keybind
---@field args? table any additional arguments to pass to hl.bind

--- Handles keybind application
---
--- @param key string
--- @param cmd string | function | HL.Dispatcher
--- @param desc string
--- @param args? table
function M.binder(key, cmd, desc, args)
	args = args or {}

	if args.description == nil then
		args.description = desc
	end

	local action

	if type(cmd) == "function" then
		action = cmd
	elseif type(cmd) == "string" then
		action = hl.dsp.exec_cmd(cmd)
	end

	hl.bind(key, action, args)
end

--- Applies all keybinds
---
---@param key_binds KeyBinds[]
function M.apply_all(key_binds)
	for _, i in pairs(key_binds) do
		local args = i.args or {}
		args.description = i.desc
		M.binder(i.keys, i.cmd, i.desc, i.args)
	end
end

--- Handles rotation of the ative monitor
---
---@param clockwise boolean
local function handleRotation(clockwise)
	local active_monitor = hl.get_active_monitor()
	if not active_monitor then
		return
	end

	local name = active_monitor.name
	local curr_transform = active_monitor.transform or 0
	local next_transform = clockwise and (curr_transform + 1) % 4 or (curr_transform - 1) % 4
	hl.monitor({ output = name, transform = next_transform })
end

--- Handles clockwise rotation of the active monitor
function M.transform_clockwise()
	handleRotation(false)
end

--- Handles anticlockwise rotation of the active monitor
function M.transform_anti_clockwise()
	handleRotation(true)
end

--- Handles lid close actions
function M.handle_lid_close()
	local monitors = hl.get_monitors()

	if #monitors > 1 then
		--- Turn off internal display but keep system awake
		hl.monitor({ output = M.INTERNAL_DISPLAY, disabled = true })
	else
		--- Lock system (Suspend is handled by OS)
		hl.exec_cmd("hyprlock --immediate")
	end
end

function M.handle_lid_open()
	--- Turns on internal display
	hl.monitor({ output = M.INTERNAL_DISPLAY, disabled = false })
end

return M
