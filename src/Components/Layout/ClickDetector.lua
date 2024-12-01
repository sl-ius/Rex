local Root = script.Parent.Parent.Parent

local React = require(Root.Packages:WaitForChild("react"))

export type ClickDetectorProps = {
    Activated: (() -> ())?;
};

local Create = React.createElement

return function(props: ClickDetectorProps)
    local ClickDetector = Create("TextButton", {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        Text = "",
        TextScale = 1,
        TextTransparency = 1,

        [React.Event.Activated] = function()
            if props.Activated then
                props.Activated()
            end
        end
    })

    return ClickDetector
end