LTrails.OurTrials = LTrails.OurTrials or {}
LTrails.CurrentEquipped = false

function LTrails:OpenMenu()
    if IsValid(LTrails.Menu) then LTrails.Menu:Remove() end
    if not LTrails.Config.Trails or #LTrails.Config.Trails < 1 then return end

    LTrails.Menu = vgui.Create("PIXEL.Frame")
    LTrails.Menu:SetTitle("LTrails")
    LTrails.Menu:SetSize(PIXEL.Scale(400), PIXEL.Scale(500))
    LTrails.Menu:Center()
    LTrails.Menu:MakePopup()

    LTrails.Menu.Sidebar = LTrails.Menu:Add("PIXEL.Sidebar")
    LTrails.Menu.Sidebar:Dock(LEFT)
    LTrails.Menu.Sidebar:SetWide(PIXEL.Scale(150))

    LTrails.Menu.ContentPanel = LTrails.Menu:Add("LTrails:Menu")
    LTrails.Menu.ContentPanel:Dock(FILL)

    for k, v in ipairs(LTrails.Config.Trails) do
        LTrails.Menu.Sidebar:AddItem(k, v.name, nil, function() 
            local pnl = LTrails:ChangeTab(LTrails.Menu, "LTrails:Menu", k)
        end)
    end
    LTrails.Menu.Sidebar:SelectItem(1)
end
net.Receive("LTrails:Menu", function() LTrails:OpenMenu() end)

function LTrails:ChangeTab(self, panel, k)
    if IsValid(self.ContentPanel) then self.ContentPanel:Remove() end
    self.ContentPanel = vgui.Create(panel, self)
    self.ContentPanel:Dock(FILL)
    self.ContentPanel:SetID(k)
    return self.ContentPanel
end

net.Receive("LTrails:UnequipTrail", function()
    LTrails.CurrentEquipped = false
end)

net.Receive("LTrails:EquippedTrail", function()
    LTrails.CurrentEquipped = net.ReadString()
end)

net.Receive("LTrails:RemoveTrail", function()
    LTrails.OurTrials[net.ReadString()] = false
end)

net.Receive("LTrails:AddTrail", function()
    LTrails.OurTrials[net.ReadString()] = true
end)

net.Receive("LTrails:NetworkTrails", function()
    local int = net.ReadUInt(32)
    for i = 1, int do
        LTrails.OurTrials[net.ReadString()] = true
    end
end)