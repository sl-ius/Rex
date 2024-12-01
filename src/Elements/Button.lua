local Root = script.Parent.Parent

local Packages = Root.Packages
local Components = Root.Components

local React = require(Packages:WaitForChild("react"))

local create = React.createElement
local useState, useEffect = React.useState, React.useEffect

local Element = {}
Element.__index = Element
Element.__type = "Button"

function Element:New(configs)
    assert(configs.Title, "No title for Button Element")
    return create("Frame", {

    })
end

return Element