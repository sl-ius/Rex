local Root = script.Parent.Parent.Parent

local React = require(Root.Packages:WaitForChild("react"))

export type PaddingList = {
    All: number?,
    Top: number?,
    Bottom: number?,
    Left: number?,
    Right: number?,
};

local Create = React.createElement

return function(props: PaddingList)
    local Padding = Create("UIPadding", {
        PaddingTop = UDim.new(0, props.Top or props.All),
        PaddingBottom = UDim.new(0, props.Bottom or props.All),
        PaddingLeft = UDim.new(0, props.Left or props.All),
        PaddingRight = UDim.new(0, props.Right or props.All)
    })

    return Padding
end