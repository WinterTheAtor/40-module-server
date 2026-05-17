--!strict
--!nolint LocalShadow

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.fusion)

local function renderOpenButton(
    scope: Fusion.Scope<typeof(Fusion)>
)

    local isHeldDown = scope:Value(false)
    local isHovering = scope:Value(false)

    return scope:New "ImageButton" ({
        Name = "OpenButton";
        AnchorPoint = Vector2.new(.5, .5);
        Position = UDim2.fromScale(.5, .9);
        Size = UDim2.fromScale(.3, .1);
        BackgroundTransparency = 1;
        Image = "";
        
        [Fusion.Children] = {
            scope:New "UIAspectRatioConstraint" {AspectRatio = 4};
            scope:New "UIScale" {Scale = scope:Spring(scope:Computed(function(use)
                return if use(isHovering) and not use(isHeldDown) then 1.1 elseif use(isHeldDown) then 1 else 1
            end), 30, 1)};

            Content = scope:New "Frame" ({
                Name = "Content";
                AnchorPoint = Vector2.new(.5, .5);
                Size = UDim2.fromScale(1, 1);
                Position = scope:Spring(scope:Computed(function(use)
                    return if use(isHovering) then UDim2.fromScale(.5, .45) else UDim2.fromScale(.5, .5)
                end), 30, 1);
                BackgroundColor3 = Color3.fromRGB(139, 226, 40);

                [Fusion.Children] = {
                    scope:New "UICorner" {CornerRadius = UDim.new(.15, 0)};

                    scope:New "TextLabel" ({
                        Name = "Title";
                        AnchorPoint = Vector2.new(.5, .5);
                        Position = UDim2.fromScale(.55, .5);
                        Size = UDim2.fromScale(.7, .5);
                        BackgroundTransparency = 1;

                        TextScaled = true;
                        Font = Enum.Font.FredokaOne;
                        TextColor3 = Color3.fromRGB(99, 134, 59);
                        Text = "Catalog Buyer 2.0 (Open Me)";

                        [Fusion.Children] = {
                            scope:New "UIAspectRatioConstraint" {AspectRatio = 6}
                        }
                    });

                    scope:New "ImageLabel" ({
                        Name = "Icon";
                        AnchorPoint = Vector2.new(.5, .5);
                        Position = UDim2.fromScale(.15, .5);
                        Size = UDim2.fromScale(.5, .5);
                        BackgroundTransparency = 1;

                        Image = "http://www.roblox.com/asset/?id=6031265968";
                        ImageColor3 = Color3.fromRGB(99, 134, 59);

                        [Fusion.Children] = {
                            scope:New "UIAspectRatioConstraint" {AspectRatio = 1}
                        }
                    });

                    scope:New "ImageLabel" ({
                        Name = "Shadow";
                        AnchorPoint = Vector2.new(.5, .5);
                        Position = UDim2.fromScale(.5, .5);
                        Size = UDim2.new(1, 60, 1, 60);
                        BackgroundTransparency = 1;
                        
                        ImageTransparency = scope:Spring(scope:Computed(function(use)
                            return if use(isHovering) then 0.5 else 1
                        end), 30, 1);
                        ImageColor3 = Color3.fromRGB(74, 114, 28);
                        Image = "rbxassetid://6150493168";
                        ScaleType = Enum.ScaleType.Slice;
                        SliceCenter = Rect.new(100,100,100,100);
                        SliceScale = 0.4;
                    })
                }
            })
        };

        [Fusion.OnEvent "MouseButton1Down"] = function()
            isHeldDown:set(true)
        end;

        [Fusion.OnEvent "MouseButton1Up"] = function()
            isHeldDown:set(false)
        end;

        [Fusion.OnEvent "MouseEnter"] = function()
            isHovering:set(true)
        end;

        [Fusion.OnEvent "MouseLeave"] = function()
            isHeldDown:set(false)
            isHovering:set(false)
        end
    })
end

return renderOpenButton