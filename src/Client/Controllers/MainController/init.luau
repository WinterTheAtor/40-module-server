--!strict
--!nolint LocalShadow

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages

local Knit = require(Packages.knit)
local Fusion = require(Packages.fusion)

local MainController = Knit.CreateController {Name = "MainController"}


local scope = Fusion.scoped(Fusion, {
    OpenButton = require(script.Components.OpenButton);
    MainContent = require(script.Components.OpenContent)
})

function MainController:KnitStart()

    local isActive = scope:Value(false)
    local TextBoxValue = scope:Value("")
    local itemdataSent = scope:Value(false)

    scope:New "ScreenGui" ({
        Name = "CatalogBuyer";
        ResetOnSpawn = false;
        IgnoreGuiInset = true;
        Parent = Knit.Player:WaitForChild("PlayerGui");

        [Fusion.Children] = {
            scope:OpenButton({isActive = isActive});
            scope:MainContent({isActive = isActive, TextBoxValue = TextBoxValue, itemdataSent = itemdataSent});
        }
    })
end

function MainController:KnitInit()
end

return MainController