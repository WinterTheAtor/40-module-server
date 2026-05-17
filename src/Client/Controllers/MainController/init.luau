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

    scope:New "ScreenGui" ({
        Name = "CatalogBuyer";
        ResetOnSpawn = false;
        IgnoreGuiInset = true;
        Parent = Knit.Player:WaitForChild("PlayerGui");

        [Fusion.Children] = {
            scope:OpenButton();
            scope:MainContent()
        }
    })
end

function MainController:KnitInit()
end

return MainController