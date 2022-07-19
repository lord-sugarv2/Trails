function LTrails:CreateDatabase()
    sql.Query("CREATE TABLE IF NOT EXISTS LTrails (SteamID TEXT, ID TEXT)")
end
hook.Add("Initialize", "LTrails:Initialize", function() LTrails:CreateDatabase() end)

util.AddNetworkString("LTrails:AddTrail")
function LTrails:AddTrail(steamid, id)
    if LTrails:HasTrail(steamid, id) then return end
    sql.Query("INSERT INTO LTrails (SteamID, ID) VALUES("..sql.SQLStr(steamid)..", "..sql.SQLStr(id)..")")

    local ply = player.GetBySteamID(steamid)
    if not IsValid(ply) then return end

    net.Start("LTrails:AddTrail")
    net.WriteString(id)
    net.Send(ply)
end

util.AddNetworkString("LTrails:RemoveTrail")
function LTrails:RemoveTrail(steamid, id)
    sql.Query("DELETE * FROM LTrails WHERE SteamID = "..sql.SQLStr(steamid).." AND id = "..sql.SQLStr(id)..";")

    local ply = player.GetBySteamID(steamid)
    if not IsValid(ply) then return end

    net.Start("LTrails:RemoveTrail")
    net.WriteString(id)
    net.Send(ply)
end

function LTrails:HasTrail(steamid, id)
    local data = sql.Query("SELECT * FROM LTrails WHERE SteamID = "..sql.SQLStr(steamid).." AND id = "..sql.SQLStr(id)..";")
    return data and true or false
end

util.AddNetworkString("LTrails:EquippedTrail")
function LTrails:EquipTrial(ply, int, col)
    local data = LTrails.Config.Trails[int]
    
    LTrails:UnequipTrail(ply)

    ply.EquippedTrail = data.id    
    for k, v in ipairs(data.bones) do
        if v == "Head" then
            local trail = util.SpriteTrail(ply, ply:LookupBone("ValveBiped.Bip01_Head1"), col, false, 15, 1, 4, 1 / ( 15 + 1 ) * 0.5, data.path)
            table.insert(ply.TrailBones, trail)
        end
        if v == "Feet" then
            local trail = util.SpriteTrail(ply, ply:LookupBone("ValveBiped.Bip01_Spine"), col, false, 15, 1, 4, 1 / ( 15 + 1 ) * 0.5, data.path)
            table.insert(ply.TrailBones, trail)
        end
        if v == "Chest" then
            local trail = util.SpriteTrail(ply, 3, col, false, 15, 1, 4, 1 / ( 15 + 1 ) * 0.5, data.path)
            table.insert(ply.TrailBones, trail)
        end
    end

    net.Start("LTrails:EquippedTrail")
    net.WriteString(data.id)
    net.Send(ply)
end

util.AddNetworkString("LTrails:UnequipTrail")
function LTrails:UnequipTrail(ply)
    ply.EquippedTrail = nil
    if ply.TrailBones then
        for k, v in ipairs(ply.TrailBones) do
            v:Remove()
        end
    end
    ply.TrailBones = {}

    net.Start("LTrails:UnequipTrail")
    net.Send(ply)
end 

util.AddNetworkString("LTrails:ClickedTrail")
net.Receive("LTrails:ClickedTrail", function(len, ply)
    local id = net.ReadInt(32)
    local col = net.ReadColor()

    local data = LTrails.Config.Trails[id]
    if not data then return end

    -- Unequip
    if ply.EquippedTrail == data.id then
        LTrails:UnequipTrail(ply)
        return
    end

    -- Equip
    if LTrails:HasTrail(ply:SteamID(), data.id) then
        LTrails:EquipTrial(ply, id, col)
        return
    end

    -- Purchase
    if not ply:canAfford(data.price) then DarkRP.notify(ply, 1, 3, "You cannot afford this!") return end
    ply:addMoney(data.price)
    LTrails:AddTrail(ply:SteamID(), data.id)
    DarkRP.notify(ply, 1, 3, "Trail purchased!")
end)

util.AddNetworkString("LTrails:NetworkTrails")
hook.Add("PlayerInitialSpawn", "LTrails:NetworkTrails", function(ply)
    local trails = sql.Query("SELECT * FROM LTrails WHERE SteamID = "..sql.SQLStr(ply:SteamID())..";")
    if not trails then return end

    net.Start("LTrails:NetworkTrails")
    net.WriteUInt(#trails, 32)
    for k, v in ipairs(trails) do
        net.WriteString(v.ID)
    end
    net.Send(ply)
end)
