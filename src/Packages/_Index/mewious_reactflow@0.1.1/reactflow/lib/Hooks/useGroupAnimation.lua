local React = require(script.Parent.Parent.React)
local useBinding = React.useBinding
local useRef = React.useRef

local GroupAnimationController = {}
GroupAnimationController.__index = GroupAnimationController

type StateSetters = {
	[string]: (any) -> nil,
}

export type Animation = {
	Play: (DefaultProperties) -> Animation,
	Stop: () -> nil,
}

export type GroupAnimation = {
	[string]: Animation,
}

export type DefaultProperties = {
	[string]: any,
}

function GroupAnimationController.new(props: GroupAnimation, default: DefaultProperties, setters: StateSetters)
	local self = setmetatable({}, GroupAnimationController)

	self.currentState = "Default"
	self.animations = props
	self.state = default

	for state, animation in props do
		animation:SetListener(function(name, value)
			if self.currentState ~= state then
				-- warn("IGNORED UPDATE:", state, name, value)
				return
			end

			-- warn("UPDATE:", state, name, value)
			self.state[name] = value
			setters[name](value)
		end)
	end

	return self
end

function GroupAnimationController:Play(newState: string)
	local animation = self.animations[newState]
	assert(animation, `No animation found for state {newState}`)

	self.currentState = newState

	if self.currentAnimation then
		self.currentAnimation:Stop()
	end

	self.currentAnimation = animation
	animation:Play(self.state)
end

function GroupAnimationController:Stop()
	if self.currentAnimation then
		self.currentAnimation:Stop()
		self.currentAnimation = nil
	end
end

local function getStateContainer(defaults: DefaultProperties)
	local setters = {}
	local values = {}

	for name, value in defaults do
		local binding, updateBinding = useBinding(value)

		setters[name] = updateBinding
		values[name] = binding
	end

	return setters, values
end

local function useGroupAnimation(props: GroupAnimation, default: DefaultProperties)
	local controller = useRef()
	local current = controller.current
	local setters, values = getStateContainer(default)

	if not current then
		local newController = GroupAnimationController.new(props, default, setters)

		current = {
			play = function(newState: string)
				assert(typeof(newState) == "string", "useGroupAnimation expects a string 'state'")

				newController:Play(newState)
			end,

			stop = function()
				newController:Stop()
			end,

			getCurrent = function()
				return newController.currentState
			end,
		}

		controller.current = current
	end

	return values, current.play, current.stop, current.getCurrent
end

return useGroupAnimation
