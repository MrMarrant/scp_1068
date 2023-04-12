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

if (SERVER) then
    function SCP_1068.DisplayEffectClientSide(effectName, pos)
		local effectdata = EffectData()
		effectdata:SetOrigin( pos )
		util.Effect( effectName, effectdata )
        net.Start(SCP_1068_CONFIG.DisplayEffectClientSide)
            net.WriteVector(pos)
            net.WriteString( effectName )
        net.Broadcast()
    end

end

if (CLIENT) then
    net.Receive(SCP_1068_CONFIG.DisplayEffectClientSide, function ()
        local pos = net.ReadVector()
        local effectName = net.ReadString()
		local effectdata = EffectData()
		effectdata:SetOrigin( pos )
		util.Effect( effectName, effectdata )
    end)
end