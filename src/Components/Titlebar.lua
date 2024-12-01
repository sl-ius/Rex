local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local CoreGui = game:GetService("CoreGui")
local Mouse = LocalPlayer:GetMouse()

local Root = script
local Elements = Root.Elements
local Components = Root.Components
local Layout = Components.Layout

local List = require(Layout.List)
local Corner = require(Layout.Corner)
local ClickDetector = require(Layout.ClickDetector)

local React = require(Root.Packages:WaitForChild("react"))
local ReactRoblox = require(Root.Packages:WaitForChild("react-roblox"))

local Create = ReactRoblox.createElement

return function(Props)
    local Library = require(Root)

    local Titlebar = {}

    local function BarButton(Icon: string, Order: number?, Callback: (() -> ()))
        return Create("Frame", {
            BackgroundTransparency = 1,
            BackgroundColor3 = Color3.fromRGB(40, 40, 40),
            Size = UDim2.fromOffset(30, 30),
            LayoutOrder = Order
        }, {
            Round = Create(Corner, {
                Rounded = 8
            }),

            Label = Create("ImageLabel", {
                AnchorPoint = UDim2.fromScale(0.5, 0.5),
                BackgroundTransparency = 1,
                Position = UDim2.fromScale(0.5, 0.5),
                Size = UDim2.fromOffset(20, 20),
                Image = Icon,
            }),

            ClickDetector = Create(ClickDetector, {
                Activated = function()
                    Callback()
                end
            })
        })
    end

    Titlebar.Frame = Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.new(1, 0, 0, 50),
    }, {
        Logo = Create("Frame", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 20, 0.5, 0),
            Size = UDim2.fromOffset(18, 18)
        }, {
            Label = Create("ImageLabel", {
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1),
                Image = "rbxassetid://84141880306400"
            })
        }),

        Title = Create("TextLabel", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 50, 0.5, 0),
            Size = UDim2.fromOffset(300, 20),
            Font = Font.new(
                "rbxassetid://12187365364",
                Enum.FontWeight.Medium,
                Enum.FontStyle.Normal
            ),
            Text = Props.Name,
            TextSize = 15,
            TextXAlignment = Enum.TextXAlignment.Left
        }),

        Behavior = Create("Frame", {
            AnchorPoint = Vector2.new(1, 0.5),
            BackgroundTransparency = 1,
            Position = UDim2.new(1, -9, 0.5, 0),
            Size = UDim2.fromOffset(110, 35)
        }, {
            List = Create(List, {
                Padding = UDim.new(0, 8),
                Direction = Enum.FillDirection.Horizontal,
                AlignX = Enum.HorizontalAlignment.Center,
                AlignY = Enum.VerticalAlignment.Center,
                Order = Enum.SortOrder.LayoutOrder,
            }),

            Close = Create(BarButton, {
                Icon = "rbxassetid://73844655151396",
                Order = 3,
                Callback = function()
                    Library:Destroy()
                end
            }),

            Resize = Create(BarButton, {
                Icon = "rbxassetid://108624244578016",
                Order = 2,
                Callback = function()
                    Library.Window:Resize()
                end
            }),

            Minimize = Create(BarButton, {
                Icon = "rbxassetid://113972216705722",
                Order = 1,
                Callback = function()
                    Library.Window:Minimize()
                end
            })
        })

    })

    return Titlebar
end