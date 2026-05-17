--!strict
--!nolint LocalShadow

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.fusion)

local function renderMainContent(
    scope: Fusion.Scope<typeof(Fusion)>
)

    return scope:New "CanvasGroup" ({
        Name = "MainContent";
        AnchorPoint = Vector2.new(.5, .5);
    })
end


return renderMainContent