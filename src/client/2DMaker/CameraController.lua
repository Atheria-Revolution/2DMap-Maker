--[[
    Author: StarShadow64/AtheriaRevolution
    Creation Date: 13/01/2023

    Description:
        No description provided.

    Documentation:
        No documentation provided.
--]]

--> Root <--

local CameraController = { }

--> Roblox Services <--

local UserInputSRV = game:GetService("UserInputService")

--> Modules & Config <--

--> Constants <--

local player = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera
local mouse = player:GetMouse()

--> Variables <--

local CurrentCamBlock = nil
local zoom_max = -5
local zoom_min = -10

local isMovingCamera = false
local mouseDelta = nil

--> Functions <--

--> Job API <--

function CameraController:InitCamera()
    CurrentCamBlock = Instance.new("Part", game.Workspace)
    CurrentCamBlock.Name = "CameraPosition"
    CurrentCamBlock.Transparency = 1
    CurrentCamBlock.Size = Vector3.new(2,2,2)
    CurrentCamBlock.Position = Vector3.new(25, 20, -25)
    CurrentCamBlock.Orientation = Vector3.new(0,180,0)
    CurrentCamBlock.Anchored = true
    repeat camera.CameraType = Enum.CameraType.Scriptable until camera.CameraType == Enum.CameraType.Scriptable
    camera.CFrame = CurrentCamBlock.CFrame
end

function CameraController:FocusCamera(SizeL, SizeW)
    local LargestS
    if SizeL > SizeW then LargestS = SizeL else LargestS = SizeW end

    CurrentCamBlock.Position = Vector3.new(SizeL/2, SizeW/2, -LargestS)
    camera.CFrame = CurrentCamBlock.CFrame

    CurrentCamBlock.Changed:Connect(function()
        camera.CFrame = CurrentCamBlock.CFrame
    end)

    mouse.WheelForward:Connect(function()
        if CurrentCamBlock.Position.Z < zoom_max then
            CurrentCamBlock.Position = CurrentCamBlock.Position + Vector3.new(0,0,1)
        end
    end)

    mouse.WheelBackward:Connect(function()
        if CurrentCamBlock.Position.Z > -LargestS + zoom_min then
            CurrentCamBlock.Position = CurrentCamBlock.Position - Vector3.new(0,0,1)
        end
    end)

    UserInputSRV.InputBegan:Connect(function(input, gameProcessedEvent)
        if input.UserInputType == Enum.UserInputType.MouseButton3 then
            isMovingCamera = true
            UserInputSRV.MouseBehavior = Enum.MouseBehavior.LockCenter
        end
    end)

    UserInputSRV.InputChanged:Connect(function(input, gameProcessedEvent)
        if input.UserInputType == Enum.UserInputType.MouseMovement and isMovingCamera == true then
            mouseDelta = Vector2.new(-input.Delta.X, -input.Delta.Y)
            CurrentCamBlock.Position = CurrentCamBlock.Position + Vector3.new(mouseDelta.X*0.05, mouseDelta.Y*0.05, 0)
        end
    end)

    UserInputSRV.InputEnded:Connect(function(input, gameProcessedEvent)
        if input.UserInputType == Enum.UserInputType.MouseButton3 then
            isMovingCamera = false
            UserInputSRV.MouseBehavior = Enum.MouseBehavior.Default
        end
    end)
end

return CameraController