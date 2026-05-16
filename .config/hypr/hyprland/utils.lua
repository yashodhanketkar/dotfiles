local M = {}

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

return M
