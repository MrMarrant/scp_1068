-- SCP 1068, A representation of a paranormal object on a fictional series on the game Garry's Mod.
-- Copyright (C) 2023  MrMarrant aka BIBI.

-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.

-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.

AddCSLuaFile("shared.lua")
include("shared.lua")

local HardImpactSoundList = {
	"physics/metal/metal_sheet_impact_hard2.wav",
	"physics/metal/metal_sheet_impact_hard6.wav",
	"physics/metal/metal_sheet_impact_hard7.wav",
	"physics/metal/metal_sheet_impact_hard8.wav"
}

function ENT:Precache()
	PrecacheParticleSystem( "nuke_effect_ground" )
	PrecacheParticleSystem( "Explosion" )
end

function ENT:Initialize()
	self:Precache()
	self:SetModel( "models/hand_dryer/hand_dryer.mdl" )
	self:SetModelScale( 1 )
	self:PhysicsInit( SOLID_VPHYSICS ) 
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid( SOLID_VPHYSICS ) 
	self:SetUseType(SIMPLE_USE)
	self:AddEffects( EF_NOINTERP )
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

function ENT:Use(ply)
	--TODO : Doit s'allumer puis détonner doit être armer
	if (ply:IsValid() and not self.Armed) then
		self:BurnBabyBurn()
	end
end

function ENT:PhysicsCollide(data, phys)
	--TODO : Si armé, explose au prochain impact
	if data.DeltaTime > 0.2 then
		if data.Speed > 250 then
			self:EmitSound(table.Random( HardImpactSoundList ), 75, math.random(90,110), 0.5)
		else
			self:EmitSound("physics/metal/metal_solid_impact_soft" .. math.random(1, 3) .. ".wav", 75, math.random(90,110), 0.2)
		end
	end
	if data.Speed > 1 and self.Armed then
		SCP_1068.DisplayEffectClientSide("nuke_effect_ground", self:GetPos())
		SCP_1068.DisplayEffectClientSide("nuke_blastwave", self:GetPos())
		self:StopSound("scp_313/booster_sound.wav")
		self:StopSound("scp_313/lauch_sound.mp3")
		self:Remove()
	end
end

function ENT:BurnBabyBurn()
	local phys = self:GetPhysicsObject()
	phys:EnableMotion( true )
	phys:Wake()
	self.Armed = true
	SCP_1068.DisplayEffectClientSide("Explosion", self:GetPos())
	self:GetPhysicsObject():SetVelocity( self:GetUp() * 10000 )
	self:EmitSound( "scp_313/lauch_sound.mp3")
	self:StartLoopingSound("scp_313/booster_sound.wav")
end