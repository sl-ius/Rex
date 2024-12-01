--[[
    Rex - UI Library
    By Sius

    Inspired by: https://github.com/dawid-scripts/Fluent/tree/master
    Licensed by MIT.
--]]

local LocalPlayer = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local Mouse = LocalPlayer:GetMouse()

local Root = script
local ComponentFolder = Root.Components
local ThemeFolder = Root.Themes

local ProtectGui = protectgui or (syn and syn.protect_gui) or function() end

local Library = {
    Version = "Release v1",
    Theme = "Default",
    Loading = false,

	MinimizeKeybind = nil,
	MinimizeKey = Enum.KeyCode.LeftControl,
}

local Elements = {}
Elements.__index = Elements
Elements.__namecall = function(Table, Key, ...)
	return Elements[Key](...)
end

for _, ElementComponent in ipairs(ElementsTable) do
	Elements["Add" .. ElementComponent.__type] = function(self, Idx, Config)
		ElementComponent.Container = self.Container
		ElementComponent.Type = self.Type
		ElementComponent.ScrollFrame = self.ScrollFrame
		ElementComponent.Library = Library

		return ElementComponent:New(Idx, Config)
	end
end