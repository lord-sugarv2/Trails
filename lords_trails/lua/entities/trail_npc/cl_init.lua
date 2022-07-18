include("shared.lua")

function ENT:Draw()
	self:DrawModel()
	PIXEL.DrawNPCOverhead(self, LTrails.Config.NPC.HeadText)
end