--[[
    Author: StarShadow64/AtheriaRevolution
    Creation Date: 13/01/2023

    Description:
        No description provided.

    Documentation:
        No documentation provided.
--]]

--> Root <--

local RobloxDDMaker = { }

--> Roblox Services <--

--> Modules & Config <--

local CamController = require(script:FindFirstChild("CameraController"))
local UIController = require(script:FindFirstChild("UIController"))
local EnvLoader = require(script:FindFirstChild("EnvironementLoader"))
local TMManager = require(script:FindFirstChild("TilemapManager"))

--> Constants <--

local UsingTilemap = nil
local LoadedMap = nil

--> Variables <--

--> Functions <--

--> Job API <--

function RobloxDDMaker:Init()
    CamController:InitCamera() -- To set up
    local InputEntered, SecondInput = UIController:CreateNewPrompt("Tilemap Controller", "Please input a Tilemap ID and a Tilemap Size in order to set up the 2D Environement", "Enter Tilemap ID Here", "Enter Tilemap Size here (pixelPerUnit)")
    UsingTilemap = TMManager:ImportTilemap(InputEntered, SecondInput, 160, 120)
    InputEntered, SecondInput = UIController:CreateNewPrompt("Tile Loader", "Please input a grid size for your project : Weight / Lenght (in tiles)", "Enter Weight Here", "Enter Lenght Here")
    LoadedMap = EnvLoader:LoadEmpthy(InputEntered, SecondInput) -- To finish
    task.wait(200)
    CamController:FocusCamera(LoadedMap) -- To set up
end

return RobloxDDMaker