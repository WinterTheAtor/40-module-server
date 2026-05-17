--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.knit)

Knit.AddServicesDeep(game:GetService("ServerStorage").Services)
Knit.Start():andThenCall(print, "Knit Services has started"):catch(warn)