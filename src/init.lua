--[[
    Rex UI Library by Sius - Release v1
    ©2024 Rex Scripts. All rights reserved.
    Licensed by MIT.
--]]

local LocalPlayer = game:GetService("Players").LocalPlayer
local Camera = game:GetService("Workspace").CurrentCamera
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

print("ok")