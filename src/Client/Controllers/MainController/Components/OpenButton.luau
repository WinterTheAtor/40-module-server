--!strict
--!nolint LocalShadow

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.fusion)

local function renderOpenButton(
    scope: Fusion.Scope<typeof(Fusion)>,
    props: {
        isActive: Fusion.Value<boolean>
    }
): (Fusion.Child)

    local isHeldDown = scope:Value(false)
    local isHovering = scope:Value(false)

    return scope:New "ImageButton" ({
        Name = "OpenButton";
        AnchorPoint = Vector2.new(.5, .5);
        Position = UDim2.fromScale(.5, .9);
        Size = UDim2.fromScale(.1, .1);
        BackgroundTransparency = 1;
        
        [Fusion.Children] = {
            scope:New "UIAspectRatioConstraint" {AspectRatio = 1};
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
                BackgroundColor3 = Color3.fromRGB(10, 10, 10);
                BackgroundTransparency = 0.2;

                [Fusion.Children] = {
                    scope:New "UICorner" {CornerRadius = UDim.new(.15, 0)};

                    scope:New "UIStroke" {
                        Thickness = 4;
                        Color = Color3.fromRGB(35,35,35);
                    };

                    scope:New "ImageLabel" ({
                        Name = "Icon";
                        AnchorPoint = Vector2.new(.5, .5);
                        Position = UDim2.fromScale(.5, .5);
                        Size = UDim2.fromScale(.6, .6);
                        BackgroundTransparency = 1;

                        Image = "http://www.roblox.com/asset/?id=6031265968";
                        ImageColor3 = Color3.fromRGB(255,255,255);

                        [Fusion.Children] = {
                            scope:New "UIAspectRatioConstraint" {AspectRatio = 1}
                        }
                    });

                    scope:New "ImageLabel" ({
                        Name = "Shadow";
                        AnchorPoint = Vector2.new(.5, .5);
                        Position = UDim2.fromScale(.5, .5);
                        Size = UDim2.new(1, 45, 1, 45);
                        BackgroundTransparency = 1;
                        ZIndex = -10;
                        
                        ImageTransparency = scope:Spring(scope:Computed(function(use)
                            return if use(isHovering) then 0.7 else 1
                        end), 30, 1);
                        ImageColor3 = Color3.fromRGB(81, 27, 143);
                        Image = "rbxassetid://6150493168";
                        ScaleType = Enum.ScaleType.Slice;
                        SliceCenter = Rect.new(100,100,100,100);
                        SliceScale = 0.4;
                    })
                }
            })
        };

        [Fusion.OnEvent 'Activated'] = function()
            props.isActive:set(not scope.peek(props.isActive))
        end;

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