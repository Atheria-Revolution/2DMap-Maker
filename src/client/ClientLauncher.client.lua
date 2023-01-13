--[[
    Author: StarShadow64/AtheriaRevolution
    Creation Date: 13/01/2023

    Description:
        No description provided.

    Documentation:
        No documentation provided.
--]]

--> Roblox Services <--

--> Modules & Config <--

--> Constants <--

--> Variables <--

--> Functions <--

local function setGraphics()
    game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
    game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, false)
    game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
    game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
    game.StarterGui:SetCore("ResetButtonCallback", false)
end

--> Job API <--

local player = game.Players.LocalPlayer

player.CharacterAdded:Connect(function()
    repeat task.wait() until player.Character:FindFirstChild("HumanoidRootPart")
    player.Character.HumanoidRootPart.Anchored = true
    while true do
        local success, err = pcall(setGraphics)
        if success then break end
    end

    for i, modules in pairs(script.Parent:GetChildren()) do
        if modules:IsA("ModuleScript") then
            local loadedModule = require(modules)
            if loadedModule["Init"] then task.delay(.05, function() loadedModule:Init() end) end
        end
    end
end)