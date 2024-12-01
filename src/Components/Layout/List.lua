local Root = script.Parent.Parent.Parent

local React = require(Root.Packages:WaitForChild("react"))

export type ListProps = {
    Padding: number?,
    Direction: Enum.FillDirection?,
    AlignX: Enum.HorizontalAlignment?,
    AlginY: Enum.VerticalAlignment?,
    Order: Enum.SortOrder?,
};

local Create = React.createElement

return function(props: ListProps)
    local List = Create("UIListLayout", {
        Padding = UDim.new(0, props.Padding),
        FillDirection = props.Direction,
        HorizontalAlignment = props.AlignX,
        VerticalAlignment = props.AlginY,
        SortOrder = props.Order,
    })

    return List
end