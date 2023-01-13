--[[
    Author: StarShadow64/AtheriaRevolution
    Creation Date: 13/01/2023

    Description:
        No description provided.

    Documentation:
        No documentation provided.
--]]

--> Root <--

local TilemapManager = { }

--> Roblox Services <--

--> Modules & Config <--

--> Constants <--

local player = game.Players.LocalPlayer

--> Variables <--
local Identifier = 0

--> Functions <--

--> Job API <--

function TilemapManager:ImportTilemap(TilemapID, MapSize, TilemapSizeL, TilemapSizeW)
    local NewTileBlock = Instance.new("Part", game.Workspace)
    NewTileBlock.Name = "TileBlock"
    NewTileBlock.Anchored = true
    NewTileBlock.Position = Vector3.new(100,100,100)
    NewTileBlock.Size = Vector3.new(1,1,0.0000000001)
    NewTileBlock.Transparency = 1
    NewTileBlock.CanCollide = false
    --local NewSB = Instance.new("SelectionBox", NewTileBlock)
    --NewSB.Adornee = NewTileBlock
    --NewSB.Name = "SelectionBox"
    --NewSB.Color3 = Color3.fromRGB(255,255,255)
    --NewSB.LineThickness = 0.0005
    local NewTileGUI = Instance.new("SurfaceGui", NewTileBlock)
    local NewTilemap = Instance.new("ImageLabel", NewTileGUI)
    NewTilemap.Name = "FullTilemap"
    NewTilemap.Size = UDim2.new(1,0,1,0)
    NewTilemap.Image = "rbxassetid://"..TilemapID
    NewTilemap.ResampleMode = Enum.ResamplerMode.Pixelated
    NewTilemap.BackgroundTransparency = 1
    
    local TotalTileL = TilemapSizeL / MapSize
    local TotalTileW = TilemapSizeW / MapSize

    print("Loading Tileset...")
    for w=0, TotalTileW do
        for l=0, TotalTileL do
            local NewTile = NewTileBlock:Clone()
            NewTile.Parent = game.Workspace
            NewTile.Name = "Tile_"..Identifier
            NewTile.SurfaceGui.FullTilemap.ImageRectSize = Vector2.new(8,8)
            NewTile.SurfaceGui.FullTilemap.ImageRectOffset = Vector2.new(8*l, 8*w)
            NewTile.Position = Vector3.new(TotalTileL - l,TotalTileW - w, 0)
            --NewTile.SelectionBox.Adornee = NewTile
            NewTile.Parent = game.ReplicatedStorage:FindFirstChild("LoadedTilemaps")
            Identifier = Identifier + 1
        end
    end

    print("Tileset loaded : "..TotalTileW * TotalTileL.." tiles loaded !")
    NewTileBlock:Destroy()

    return game.ReplicatedStorage:FindFirstChild("LoadedTilemaps")
end

return TilemapManager