--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.knit)

Knit.AddControllersDeep(ReplicatedStorage.Controllers)
Knit.Start():andThenCall(print, "Knit Client has started"):catch(warn)