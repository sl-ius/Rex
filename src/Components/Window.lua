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

local Create = ReactRoblox.createElement

local Titlebar = require(Root.Components.Titlebar)

return function(Props)
    local Library = require(Root)

    local Window = {
        Minimized = false,
        Size = Props.Size,
    }

    Window.Root = Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        Position = UDim2.fromScale(0.5, 0.5),
        Parent = Props.Parent,
        Size = Props.Size,
    }, {
        TitleBar = Create(Titlebar, {
            Name = Props.Name
        })
    })

    return Window
end