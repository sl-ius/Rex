--[[
    Rex - UI Library
    By Sius

    Inspired by: https://github.com/dawid-scripts/Fluent/tree/master
    Licensed by MIT.
--]]

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local CoreGui = game:GetService("CoreGui")
local Mouse = LocalPlayer:GetMouse()

local Root = script
local Elements = Root.Elements
local Components = Root.Components

local React = require(Root.Packages:WaitForChild("react"))
local ReactRoblox = require(Root.Packages:WaitForChild("react-roblox"))

local Create = React.createElement

local Window = require(Components.Window)
local Elements = Root.Elements

local ProtectGui = protectgui or (syn and syn.protect_gui) or function() end

local Container = Instance.new("Folder")
Container.Parent = RunService:IsStudio() and LocalPlayer.PlayerGui or CoreGui

ProtectGui(Container)

local UIRoot = ReactRoblox.createRoot(Container)

local Library = {
	Window = nil,
	WindowFrame = nil,
	Unloaded = false,

	Theme = "Dark",
	DialogOpen = false,
	MinimizeKeybind = nil,
	MinimizeKey = Enum.KeyCode.LeftControl,

	Container = Container,
}

local Elements = {}
Elements.__index = Elements
Elements.__namecall = function(Table, Key, ...)
	return Elements[Key](...)
end

--[[
for _, Components in ipairs(Elements) do
	Elements["New" .. Components.__type] = function(self, Idx, Config)
		Components.Type = self.Type
		Components.Library = Library

		return Components:New(Idx, Config)
	end
end
--]]

function Library:NewWindow(Props)
    assert(Props.Name, "Window Error - Missing Name")

    if Library.Window then
        warn("You cannot create more than one window")
        return
    end

    Library.MinimizeKey = Props.MinimizeKey or Enum.KeyCode.LeftAlt
    Library.Theme = Props.Theme or "Dark"

    local Window = Create(Window, {
        Parent = Container,
		Size = Props.Size,
		Name = Props.Name
    })

    Library.Window = Window

	UIRoot:render(Create(Window))
end

function Library:Destroy()
	if Library.Window then
		Library.Unloaded = true
		Library.Container:Destroy()
	end
end