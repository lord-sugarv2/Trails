AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel(LTrails.Config.NPC.Model)
	self:SetSolid(SOLID_BBOX)
	self:SetHullSizeNormal()
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetHullType(HULL_HUMAN)
	self:SetUseType(SIMPLE_USE)
	self:SetMaxYawSpeed(90)
	self:CapabilitiesAdd(CAP_ANIMATEDFACE)
	self:CapabilitiesAdd(CAP_TURN_HEAD)
	self:DropToFloor()
end

util.AddNetworkString("LTrails:Menu")
function ENT:Use(ply)
	net.Start("LTrails:Menu")
	net.Send(ply)
end