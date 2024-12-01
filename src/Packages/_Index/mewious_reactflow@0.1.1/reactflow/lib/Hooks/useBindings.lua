local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Client.Modules.React).React

local subscribeToBinding = React.__subscribeToBinding
local useEffect = React.useEffect

export type ReactBinding = typeof(React.useBinding())

local function useBindings(callback: (...any) -> (), bindings: { ReactBinding }, deps: { any }?)
	useEffect(function()
		local disconnects = {}
		local values = {}

		local running = true
		local numBindings = #bindings

		-- CRITICAL: need to assign values in reverse order otherwise
		-- LUA will automatically convert table to a dictionary whenever
		-- there is a nil entry. This will cause the unpack to fail
		-- and the callback to receive the wrong number of arguments
		for i = numBindings, 1, -1 do
			local bindingRef = bindings[i]
			values[i] = if bindingRef then bindingRef:getValue() else nil
		end

		for i = 1, numBindings do
			local idx = i
			local bindingRef = bindings[i]

			if not bindingRef then
				continue
			end

			disconnects[idx] = subscribeToBinding(bindingRef, function(newValue)
				if not running then
					warn("Binding updated after unmount")
					return
				end

				local oldValue = values[idx]
				values[idx] = newValue

				if oldValue ~= newValue or typeof(newValue) == "table" then
					callback(unpack(values))
				end
			end)
		end

		callback(unpack(values))

		return function()
			for _, disconnect in disconnects do
				disconnect()
			end

			running = false
			table.clear(disconnects)
			table.clear(values)
		end
	end, { unpack(bindings), unpack(deps or {}) })
end

return useBindings
