-- BetterThrowingKnives, Cyberpunk 2077 mod that improves throwing knives
-- Copyright (C) 2022 BurgersMcFly

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

registerForEvent("onInit", function() 

--default minimumReloadTime = 0.9f; || lower values = faster reload
--default knifeWeaponSwapOnAttackDelay = 0.4f; || higer values will prevent V from changing to a different weapon when clicking left/right mouse button too fast

TweakDB:SetFlat("Items.Base_Knife.minimumReloadTime", 0)
TweakDB:SetFlat("Items.Base_Knife.knifeWeaponSwapOnAttackDelay", 99)

end)