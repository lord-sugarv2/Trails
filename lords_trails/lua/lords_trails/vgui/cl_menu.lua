PIXEL.RegisterFont("LTrails:25", "Open Sans SemiBold", 25)

local PANEL = {}
function PANEL:Init()
    self.Name = self:Add("PIXEL.Label")
    self.Name:Dock(TOP)
    self.Name:SetText("N/A")
    self.Name:SetTextAlign(TEXT_ALIGN_CENTER)
    self.Name:SetFont("LTrails:25")

    self.Price = self:Add("PIXEL.Label")
    self.Price:Dock(TOP)
    self.Price:SetText("N/A")
    self.Price:SetTextAlign(TEXT_ALIGN_CENTER)
    self.Price:SetFont("LTrails:25")

    self.Image = self:Add("DImage")
    self.Image:SetImage("error")
    self.Image:Dock(TOP)
    self.Image:DockMargin(5, 5, 0, 0)

    self.col = color_white
    self.ColorPicker = self:Add("PIXEL.ColorPicker")
    self.ColorPicker:Dock(FILL)
    self.ColorPicker:DockMargin(5, 0, 0, 0)
    self.ColorPicker:SetColor(self.col)
    self.ColorPicker.OnChange = function(s, color)
        self.col = color
    end
    
    self.Button = self:Add("PIXEL.TextButton")
    self.Button:Dock(BOTTOM )
    self.Button:DockMargin(5, 5, 0, 0)
    self.Button:SetText("Purchase")
end

function PANEL:SetID(id)
    local data = LTrails.Config.Trails[id]
    if not data then return end

    self.Name:SetText(data.name)
    self.Price:SetText(DarkRP.formatMoney(data.price))
    self.Image:SetImage(data.path)

    self.Button.Think = function(s)
      
        if LTrails.OurTrials[data.id] and LTrails.CurrentEquipped == data.id then
            s:SetText("UnEquip")
            return
        elseif LTrails.OurTrials[data.id] and LTrails.CurrentEquipped ~= data.id then
            s:SetText("Equip")
            return
        end
        s:SetText("Purchase")
    end
    self.Button.DoClick = function()
        surface.PlaySound("buttons/button14.wav")
        net.Start("LTrails:ClickedTrail")
        net.WriteUInt(id, 32)
        net.WriteColor(self.col)
        net.SendToServer()
    end
end

function PANEL:PerformLayout(w, h)
    self.Name:SetTall(24)
    self.Price:SetTall(24)
    self.Image:SetTall(w*.8)
    self.Button:SetTall(h*.1)
end
vgui.Register("LTrails:Menu", PANEL, "EditablePanel")