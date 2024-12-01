local Root = script.Parent.Parent.Parent

local React = require(Root.Packages:WaitForChild("react"))

export type CornerProps = {
    Rounded: number?;
};

local Create = React.createElement

return function(props: CornerProps)
    local Corner = Create("UICorner", {
        CornerRadius = UDim.new(0, props.Rounded);
    })

    return Corner
end