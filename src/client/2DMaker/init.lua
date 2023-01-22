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

local LoadedTilemap = {["TilemapID"] = 12141026059, ["TilemapSizeL"] = 160, ["TilemapSizeW"] = 128, ["TileSize"] = 8}
local OtherTilemap1 = {["TilemapID"] = 12162674184, ["TilemapSizeL"] = 1024, ["TilemapSizeW"] = 824, ["TileSize"] = 48}

--> Functions <--

--> Job API <--

function RobloxDDMaker:Init()
    CamController:InitCamera() -- To set up
    if LoadedTilemap then
        UsingTilemap = TMManager:ImportTilemap(LoadedTilemap.TilemapID, LoadedTilemap.TileSize, LoadedTilemap.TilemapSizeL, LoadedTilemap.TilemapSizeW)
    else
        local MapID, TileSize = UIController:CreateNewPrompt("Tilemap Controller", "Please input a Tilemap ID and a Tile Size in order to set up the 2D Environement", "Enter Tilemap ID Here", "Enter Tile Size here (pixelPerUnit)")
        local SizeL, SizeW = UIController:CreateNewPrompt("Tilemap Controller", "Please input a Tilemap Size in order to set up the 2D Environement (in Pixel)", "Enter Tilemap Lenght", "Enter Tilemap Weight")
        UsingTilemap = TMManager:ImportTilemap(MapID, TileSize, SizeL, SizeW)
    end
    local GridSizeL, GridSizeW = UIController:CreateNewPrompt("Tile Loader", "Please input a environment size for your project : Weight / Lenght (in tiles)", "Enter Weight Here", "Enter Lenght Here")
    LoadedMap = EnvLoader:LoadEmpthy(GridSizeL, GridSizeW) -- To finish
    CamController:FocusCamera(GridSizeL, GridSizeW) -- To set up
end

return RobloxDDMaker