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

SCP_1068 = {}
SCP_1068_CONFIG  = {}

SCP_1068_CONFIG.DisplayEffectClientSide = "SCP_1068_CONFIG.DisplayEffectClientSide"

if (SERVER) then
    util.AddNetworkString( SCP_1068_CONFIG.DisplayEffectClientSide )
end


/*
* Allows you to charge all the files in a folder.
* @string path of the folder to load.
*/
function SCP_1068.LoadDirectory(pathFolder)
    local files, directories = file.Find(pathFolder.."*", "LUA")
    for key, value in pairs(files) do
        AddCSLuaFile(pathFolder..value)
        include(pathFolder..value)
    end
    for key, value in pairs(directories) do
        SCP_1068.LoadDirectory(pathFolder..value)
    end
end

SCP_1068.LoadDirectory("lib/functions/")