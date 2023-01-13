--[[
    Author: StarShadow64/AtheriaRevolution
    Creation Date: 13/01/2023

    Description:
        No description provided.

    Documentation:
        No documentation provided.
--]]

--> Root <--

local EnvironementLoader = { }

--> Roblox Services <--

--> Modules & Config <--

--> Constants <--

--> Variables <--

local GlobalIdentifier = 0

--> Functions <--

--> Job API <--

function EnvironementLoader:LoadEmpthy(SizeL, SizeW)
    local NewTileBlock = Instance.new("Part", game.Workspace)
    NewTileBlock.Name = "TileBlock"
    NewTileBlock.Anchored = true
    NewTileBlock.Position = Vector3.new(100,100,100)
    NewTileBlock.Size = Vector3.new(1,1,0.0000000001)
    NewTileBlock.Transparency = 1
    NewTileBlock.CanCollide = false
    local NewSB = Instance.new("SelectionBox", NewTileBlock)
    local NewTileGUI = Instance.new("SurfaceGui", NewTileBlock)
    NewSB.Adornee = NewTileBlock
    NewSB.Name = "SelectionBox"
    NewSB.Color3 = Color3.fromRGB(255,255,255)
    NewSB.LineThickness = 0.0005
    
    local TotalTileL = SizeL
    local TotalTileW = SizeW

    print("Loading Environment...")
    for w=0, TotalTileW do
        for l=0, TotalTileL do
            local NewTile = NewTileBlock:Clone()
            NewTile.Parent = game.Workspace
            NewTile.Name = "TileSpot_"..GlobalIdentifier
            NewTile.Position = Vector3.new(TotalTileL - l,TotalTileW - w, 0)
            NewTile.SelectionBox.Adornee = NewTile
            NewTile.Parent = game.Workspace:FindFirstChild("LoadedEnvironment")
            GlobalIdentifier = GlobalIdentifier + 1
        end
    end

    print("Environment loaded : "..TotalTileW * TotalTileL.." spots loaded !")
    NewTileBlock:Destroy()

    return true
end

return EnvironementLoader