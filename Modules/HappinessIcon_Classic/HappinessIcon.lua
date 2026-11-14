local _G = _G
local PitBull4 = _G.PitBull4
local L = PitBull4.L

local issecretvalue = _G.issecretvalue or function() return false end

local PitBull4_HappinessIcon = PitBull4:NewModule("HappinessIcon")

PitBull4_HappinessIcon:SetModuleType("indicator")
PitBull4_HappinessIcon:SetName(L["Happiness icon"])
PitBull4_HappinessIcon:SetDescription(L["Show an icon on the pet frame to indicate its happiness."])
PitBull4_HappinessIcon:SetDefaults({
	attach_to = "root",
	location = "edge_bottom_right",
	position = 1,
	size = 1.2,
	tooltip = true,
	only_happiness_pets = true,
})

local CLASSIC_TEXTURE = [[Interface\PetPaperDollFrame\UI-PetHappiness]]

local tex_coords = {
	-- unhappy
	{0.375, 0.5625, 0, 0.359375},

	-- content
	{0.1875, 0.375, 0, 0.359375},

	-- happy
	{0, 0.1875, 0, 0.359375},
}

local function is_valid_value(v)
	return v ~= nil and not issecretvalue(v)
end

local function is_valid_number(v)
	return type(v) == "number" and not issecretvalue(v)
end

local function is_valid_string(v)
	return type(v) == "string" and not issecretvalue(v) and v ~= ""
end

local function safe_tostring(v)
	if v == nil then
		return "nil"
	end
	if issecretvalue(v) then
		return "<secret>"
	end
	return tostring(v)
end

local function find_pet_frame_happiness_texture(pfh)
	if not pfh then
		return nil
	end
	local reg = _G.PetFrameHappinessTexture or pfh.Texture or pfh.icon or pfh.Icon
	if reg and (not reg.GetObjectType or reg:GetObjectType() == "Texture") then
		return reg
	end
	if pfh.GetRegions then
		for i = 1, select("#", pfh:GetRegions()) do
			local r = select(i, pfh:GetRegions())
			if r and r.GetObjectType and r:GetObjectType() == "Texture" then
				return r
			end
		end
	end
	return nil
end

local function get_pfh_tooltip_fields()
	local pfh = _G.PetFrameHappiness
	if not pfh then
		return nil, nil, nil
	end
	local title = is_valid_string(pfh.tooltip) and pfh.tooltip or nil
	local line1 = is_valid_string(pfh.tooltipDamage) and pfh.tooltipDamage or nil
	local line2 = is_valid_string(pfh.tooltipLoyalty) and pfh.tooltipLoyalty or nil
	return title, line1, line2
end

local function extract_tex_coords(reg)
	if not reg or not reg.GetTexCoord then
		return {0, 1, 0, 1}
	end
	local c1, c2, c3, c4, c5, c6, c7, c8 = reg:GetTexCoord()
	if c8 ~= nil then
		-- Modern WoW GetTexCoord() returns 8 values: ULx, ULy, LLx, LLy, URx, URy, LRx, LRy
		if is_valid_number(c1) and is_valid_number(c5) and is_valid_number(c2) and is_valid_number(c4) then
			return {c1, c5, c2, c4}
		end
	elseif c4 ~= nil then
		-- Legacy 4-return GetTexCoord(): left, right, top, bottom
		if is_valid_number(c1) and is_valid_number(c2) and is_valid_number(c3) and is_valid_number(c4) then
			return {c1, c2, c3, c4}
		end
	end
	return {0, 1, 0, 1}
end

local function infer_tier_from_atlas(atlas)
	local lower = atlas:lower()
	if lower:find("unhappy", 1, true) or lower:find("red", 1, true) then
		return 1
	elseif lower:find("content", 1, true) or lower:find("yellow", 1, true) or lower:find("neutral", 1, true) then
		return 2
	elseif lower:find("happy", 1, true) or lower:find("green", 1, true) then
		return 3
	end
	return nil
end

local function infer_tier_from_texcoord(left)
	if not is_valid_number(left) then
		return nil
	end
	if left < 0.18 then
		return 3
	elseif left < 0.37 then
		return 2
	else
		return 1
	end
end

local function build_tooltip_lines(tier, damage_pct, loyalty_rate, pfh_title, pfh_line1, pfh_line2)
	local title = pfh_title or (tier and _G["PET_HAPPINESS" .. tier]) or nil
	local line1 = pfh_line1
	if not line1 and is_valid_number(damage_pct) and _G.PET_DAMAGE_PERCENTAGE then
		line1 = format(_G.PET_DAMAGE_PERCENTAGE, damage_pct)
	end
	local line2 = pfh_line2
	if not line2 and is_valid_string(loyalty_rate) then
		line2 = loyalty_rate
	end
	return title, line1, line2
end

--- Probe all available 16001 pet happiness sources.
-- @return tier (1=unhappy, 2=content, 3=happy, or nil)
-- @return damage_pct (number or nil)
-- @return loyalty_rate (number/string or nil)
-- @return tex_or_atlas (texture path/fileID or atlas name, or nil)
-- @return is_atlas (boolean)
-- @return coords (table {l, r, t, b} or nil)
-- @return tooltip_title (string or nil)
-- @return tooltip_line1 (string or nil)
-- @return tooltip_line2 (string or nil)
local function get_happiness_info()
	local pfh_title, pfh_line1, pfh_line2 = get_pfh_tooltip_fields()

	-- Source 1: _G.GetPetHappiness or C_PetInfo.GetPetHappiness
	local get_pet_happiness = _G.GetPetHappiness or (_G.C_PetInfo and _G.C_PetInfo.GetPetHappiness)
	if type(get_pet_happiness) == "function" then
		local ok, raw_tier, damage_pct, loyalty_rate = pcall(get_pet_happiness)
		if ok and is_valid_number(raw_tier) then
			local tier = math.floor(raw_tier)
			if tier >= 1 and tier <= 3 then
				local valid_dmg = is_valid_number(damage_pct) and damage_pct or nil
				local valid_loyalty = is_valid_value(loyalty_rate) and loyalty_rate or nil
				local tip_title, tip_l1, tip_l2 = build_tooltip_lines(tier, valid_dmg, valid_loyalty, pfh_title, pfh_line1, pfh_line2)
				return tier, valid_dmg, valid_loyalty, CLASSIC_TEXTURE, false, tex_coords[tier], tip_title, tip_l1, tip_l2
			end
		end
	end

	-- Source 2: Enum.PowerType.Happiness via UnitPower / UnitPowerMax
	local happiness_power_type = _G.Enum and _G.Enum.PowerType and _G.Enum.PowerType.Happiness
	if is_valid_number(happiness_power_type) and _G.UnitPower and _G.UnitPowerMax then
		local p = _G.UnitPower("pet", happiness_power_type)
		local max = _G.UnitPowerMax("pet", happiness_power_type)
		if is_valid_number(p) and is_valid_number(max) and (max > 0 or (max == 0 and p > 0)) then
			local tier
			if max > 0 and max <= 3 then
				if p <= 1 then
					tier = 1
				elseif p == 2 then
					tier = 2
				else
					tier = 3
				end
			elseif max > 3 then
				local ratio = p / max
				if ratio < 0.34 then
					tier = 1
				elseif ratio < 0.67 then
					tier = 2
				else
					tier = 3
				end
			else -- max == 0 and p > 0
				if p <= 3 then
					tier = math.max(1, math.floor(p))
				elseif p < 34 then
					tier = 1
				elseif p < 67 then
					tier = 2
				else
					tier = 3
				end
			end
			local tip_title, tip_l1, tip_l2 = build_tooltip_lines(tier, nil, nil, pfh_title, pfh_line1, pfh_line2)
			return tier, nil, nil, CLASSIC_TEXTURE, false, tex_coords[tier], tip_title, tip_l1, tip_l2
		end
	end

	-- Source 3: _G.PetFrameHappiness widget (use :IsShown(), NOT :IsVisible(), because HideBlizzard hides PetFrame)
	local pfh = _G.PetFrameHappiness
	if pfh and pfh.IsShown and pfh:IsShown() then
		local reg = find_pet_frame_happiness_texture(pfh)
		if reg then
			local atlas = reg.GetAtlas and reg:GetAtlas()
			if is_valid_string(atlas) then
				local tier = infer_tier_from_atlas(atlas)
				local tip_title, tip_l1, tip_l2 = build_tooltip_lines(tier, nil, nil, pfh_title, pfh_line1, pfh_line2)
				return tier, nil, nil, atlas, true, nil, tip_title, tip_l1, tip_l2
			end

			local tex = reg.GetTexture and reg:GetTexture()
			if is_valid_string(tex) or (is_valid_number(tex) and tex > 0) then
				local coords = extract_tex_coords(reg)
				local tier = infer_tier_from_texcoord(coords[1])
				local tip_title, tip_l1, tip_l2 = build_tooltip_lines(tier, nil, nil, pfh_title, pfh_line1, pfh_line2)
				return tier, nil, nil, tex, false, coords, tip_title, tip_l1, tip_l2
			end
		end
	end

	-- Source 4: C_StableInfo.GetActivePetList / C_StableInfo.GetStablePetInfo
	local stable = _G.C_StableInfo
	if stable and type(stable.GetActivePetList) == "function" then
		local ok, active_list = pcall(stable.GetActivePetList)
		if ok and type(active_list) == "table" and #active_list > 0 then
			local raw_pet_name = _G.UnitName and _G.UnitName("pet")
			local pet_name = is_valid_string(raw_pet_name) and raw_pet_name or nil
			local raw_pet_family = _G.UnitCreatureFamily and _G.UnitCreatureFamily("pet")
			local pet_family = is_valid_string(raw_pet_family) and raw_pet_family or nil

			local matched_entry
			local fallback_entry
			for _, item in ipairs(active_list) do
				local entry = item
				if type(item) == "number" and type(stable.GetStablePetInfo) == "function" then
					local ok2, info = pcall(stable.GetStablePetInfo, item)
					entry = (ok2 and type(info) == "table") and info or nil
				end
				if type(entry) == "table" then
					local h = entry.happinessLevel
					if is_valid_number(h) then
						local tier = math.floor(h)
						if tier >= 1 and tier <= 3 then
							if pet_name and is_valid_string(entry.name) and entry.name == pet_name then
								matched_entry = entry
								break
							elseif not fallback_entry and pet_family and is_valid_string(entry.familyName) and entry.familyName == pet_family then
								fallback_entry = entry
							elseif not fallback_entry and #active_list == 1 then
								fallback_entry = entry
							end
						end
					end
				end
			end

			local chosen = matched_entry or fallback_entry
			if chosen then
				local tier = math.floor(chosen.happinessLevel)
				local loyalty = is_valid_string(chosen.loyaltyName) and chosen.loyaltyName or nil
				local tip_title, tip_l1, tip_l2 = build_tooltip_lines(tier, nil, loyalty, pfh_title, pfh_line1, pfh_line2)
				return tier, nil, loyalty, CLASSIC_TEXTURE, false, tex_coords[tier], tip_title, tip_l1, tip_l2
			end
		end
	end

	return nil
end

local function has_live_happiness_attribute(info_tex)
	if info_tex ~= nil then
		return true
	end
	local happiness_power_type = _G.Enum and _G.Enum.PowerType and _G.Enum.PowerType.Happiness
	if is_valid_number(happiness_power_type) and _G.UnitPowerMax then
		local max = _G.UnitPowerMax("pet", happiness_power_type)
		if is_valid_number(max) and max > 0 then
			return true
		end
	end
	local pfh = _G.PetFrameHappiness
	if pfh and pfh.IsShown and pfh:IsShown() then
		return true
	end
	return false
end

local function can_pet_have_happiness(db, info_tex)
	if not _G.UnitExists("pet") then
		return false
	end

	if db and db.only_happiness_pets then
		if _G.UnitClassBase("player") ~= "HUNTER" then
			return false
		end

		local has_attribute = has_live_happiness_attribute(info_tex)
		if not has_attribute then
			return false
		end

		if type(_G.HasPetUI) == "function" then
			local has_ui, is_hunter_pet = _G.HasPetUI()
			if is_valid_value(is_hunter_pet) then
				if not is_hunter_pet then
					return false
				end
			elseif is_valid_value(has_ui) and not has_ui then
				return false
			end
		end

		return true
	end

	return info_tex ~= nil
end

local hooks_installed = false
local updating_pet = false

local function on_blizzard_happiness_update()
	if updating_pet or not PitBull4_HappinessIcon:IsEnabled() then
		return
	end
	updating_pet = true
	PitBull4_HappinessIcon:UpdateForUnitID("pet")
	updating_pet = false
end

local function install_blizzard_hooks()
	if hooks_installed or type(_G.hooksecurefunc) ~= "function" then
		return
	end
	hooks_installed = true

	if _G.PetFrameHappiness then
		if type(_G.PetFrameHappiness.Show) == "function" then
			_G.hooksecurefunc(_G.PetFrameHappiness, "Show", on_blizzard_happiness_update)
		end
		if type(_G.PetFrameHappiness.Hide) == "function" then
			_G.hooksecurefunc(_G.PetFrameHappiness, "Hide", on_blizzard_happiness_update)
		end
	end
	if type(_G.PetFrame_SetHappiness) == "function" then
		_G.hooksecurefunc("PetFrame_SetHappiness", on_blizzard_happiness_update)
	end
	if type(_G.PetFrame_Update) == "function" then
		_G.hooksecurefunc("PetFrame_Update", on_blizzard_happiness_update)
	end
end

function PitBull4_HappinessIcon:OnEnable()
	self:RegisterEvent("UNIT_HAPPINESS")
	self:RegisterEvent("UNIT_PET")
	self:RegisterEvent("PET_UI_UPDATE")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("UNIT_POWER_UPDATE")
	self:RegisterEvent("PET_STABLE_UPDATE")
	install_blizzard_hooks()
end

function PitBull4_HappinessIcon:GetTexture(frame)
	if frame.unit ~= "pet" then
		frame._happiness_cache = nil
		return nil
	end

	local db = self:GetLayoutDB(frame)
	local tier, damage_pct, loyalty_rate, tex, is_atlas, coords, tip_title, tip_l1, tip_l2 = get_happiness_info()
	if not can_pet_have_happiness(db, tex) or not tex then
		frame._happiness_cache = nil
		return nil
	end

	frame._happiness_cache = {
		tier = tier,
		damage_pct = damage_pct,
		loyalty_rate = loyalty_rate,
		tex = tex,
		is_atlas = is_atlas,
		coords = coords,
		tip_title = tip_title,
		tip_l1 = tip_l1,
		tip_l2 = tip_l2,
	}
	return tex, is_atlas
end

function PitBull4_HappinessIcon:GetExampleTexture(frame)
	if frame.unit ~= "pet" then
		return nil
	end

	return CLASSIC_TEXTURE, false
end

function PitBull4_HappinessIcon:GetTexCoord(frame, texture)
	local cache = frame._happiness_cache
	if cache and cache.coords then
		local c = cache.coords
		return c[1], c[2], c[3], c[4]
	end
	return nil
end

function PitBull4_HappinessIcon:GetExampleTexCoord()
	local tex_coord = tex_coords[3] -- happy
	return tex_coord[1], tex_coord[2], tex_coord[3], tex_coord[4]
end

function PitBull4_HappinessIcon:UNIT_HAPPINESS(event, unit)
	if not unit or (not issecretvalue(unit) and unit == "pet") then
		self:UpdateForUnitID("pet")
	end
end

function PitBull4_HappinessIcon:UNIT_PET(event, unit)
	if not unit or (not issecretvalue(unit) and unit == "player") then
		self:UpdateForUnitID("pet")
	end
end

function PitBull4_HappinessIcon:PET_UI_UPDATE()
	self:UpdateForUnitID("pet")
end

function PitBull4_HappinessIcon:PLAYER_ENTERING_WORLD()
	self:UpdateForUnitID("pet")
end

function PitBull4_HappinessIcon:PET_STABLE_UPDATE()
	self:UpdateForUnitID("pet")
end

function PitBull4_HappinessIcon:UNIT_POWER_UPDATE(event, unit, power_type)
	if is_valid_string(unit) and unit == "pet" then
		if power_type == nil or (is_valid_string(power_type) and power_type == "HAPPINESS") then
			self:UpdateForUnitID("pet")
		end
	end
end

function PitBull4_HappinessIcon:GetEnableMouse(frame)
	return self:GetLayoutDB(frame).tooltip
end

function PitBull4_HappinessIcon.OnEnter(icon, motion)
	local frame = icon and icon.GetParent and icon:GetParent()
	local cache = frame and frame._happiness_cache

	local tier, damage_pct, loyalty_rate, _, _, _, tip_title, tip_l1, tip_l2 = get_happiness_info()
	if not tip_title and cache then
		tier = cache.tier
		damage_pct = cache.damage_pct
		loyalty_rate = cache.loyalty_rate
		tip_title = cache.tip_title
		tip_l1 = cache.tip_l1
		tip_l2 = cache.tip_l2
	end

	if not tip_title and tier then
		tip_title = _G["PET_HAPPINESS" .. tier]
	end
	if not tip_title then
		return
	end

	GameTooltip:SetOwner(icon, "ANCHOR_RIGHT")
	GameTooltip:SetText(tip_title)
	if tip_l1 then
		GameTooltip:AddLine(tip_l1, 1, 1, 1)
	elseif is_valid_number(damage_pct) and _G.PET_DAMAGE_PERCENTAGE then
		GameTooltip:AddLine(format(_G.PET_DAMAGE_PERCENTAGE, damage_pct), 1, 1, 1)
	end
	if tip_l2 then
		GameTooltip:AddLine(tip_l2, 1, 1, 1)
	elseif is_valid_string(loyalty_rate) then
		GameTooltip:AddLine(loyalty_rate, 1, 1, 1)
	end
	GameTooltip:Show()
end

function PitBull4_HappinessIcon.OnLeave(icon, motion)
	if GameTooltip:GetOwner() == icon then
		GameTooltip:Hide()
	end
end

PitBull4_HappinessIcon:SetLayoutOptionsFunction(function(self)
	return 'tooltip', {
		type = 'toggle',
		name = L["Tooltip"],
		desc = L["Show a tooltip on mouseover with the happiness and damage percent for the pet."],
		get = function(info)
			return PitBull4.Options.GetLayoutDB(self).tooltip
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(self).tooltip = value

			for frame in PitBull4:IterateFramesForUnitID("pet") do
				self:Clear(frame)
				self:Update(frame)
			end
		end,
	}, 'only_happiness_pets', {
		type = 'toggle',
		name = L["Auto-detect class & pet"],
		desc = L["Only show for classes and pets that have the happiness attribute (e.g. Hunter pets)."],
		get = function(info)
			return PitBull4.Options.GetLayoutDB(self).only_happiness_pets
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(self).only_happiness_pets = value

			for frame in PitBull4:IterateFramesForUnitID("pet") do
				self:Clear(frame)
				self:Update(frame)
			end
		end,
	}
end)

_G.SLASH_PB4HAPPY1 = "/pb4happy"
_G.SlashCmdList["PB4HAPPY"] = function()
	local print_line = function(msg)
		PitBull4_HappinessIcon:Print(msg)
	end

	local class_base = _G.UnitClassBase and _G.UnitClassBase("player")
	local pet_exists = _G.UnitExists and _G.UnitExists("pet")
	local has_ui, is_hunter_pet
	if type(_G.HasPetUI) == "function" then
		has_ui, is_hunter_pet = _G.HasPetUI()
	end
	print_line(format("class=%s, petExists=%s, HasPetUI=(%s, %s), enabled=%s",
		safe_tostring(class_base), safe_tostring(pet_exists), safe_tostring(has_ui), safe_tostring(is_hunter_pet), safe_tostring(PitBull4_HappinessIcon:IsEnabled())))

	if type(_G.GetPetHappiness) == "function" then
		local ok, h, d, l = pcall(_G.GetPetHappiness)
		print_line(format("_G.GetPetHappiness: ok=%s -> (%s, %s, %s)", safe_tostring(ok), safe_tostring(h), safe_tostring(d), safe_tostring(l)))
	else
		print_line("_G.GetPetHappiness: nil")
	end

	if _G.C_PetInfo and type(_G.C_PetInfo.GetPetHappiness) == "function" then
		local ok, h, d, l = pcall(_G.C_PetInfo.GetPetHappiness)
		print_line(format("C_PetInfo.GetPetHappiness: ok=%s -> (%s, %s, %s)", safe_tostring(ok), safe_tostring(h), safe_tostring(d), safe_tostring(l)))
	else
		print_line("C_PetInfo.GetPetHappiness: nil")
	end

	local pt = _G.Enum and _G.Enum.PowerType and _G.Enum.PowerType.Happiness
	if is_valid_number(pt) and _G.UnitPower and _G.UnitPowerMax then
		local p = _G.UnitPower("pet", pt)
		local m = _G.UnitPowerMax("pet", pt)
		print_line(format("PowerType.Happiness=%s, UnitPower=%s, UnitPowerMax=%s", safe_tostring(pt), safe_tostring(p), safe_tostring(m)))
	else
		print_line(format("PowerType.Happiness=%s (UnitPower unavailable)", safe_tostring(pt)))
	end

	local pfh = _G.PetFrameHappiness
	if pfh then
		local reg = find_pet_frame_happiness_texture(pfh)
		local atlas = reg and reg.GetAtlas and reg:GetAtlas()
		local tex = reg and reg.GetTexture and reg:GetTexture()
		local coords = reg and extract_tex_coords(reg)
		print_line(format("PetFrameHappiness: shown=%s, reg=%s, atlas=%s, tex=%s, tc={%s,%s,%s,%s}",
			safe_tostring(pfh.IsShown and pfh:IsShown()),
			safe_tostring(reg ~= nil),
			safe_tostring(atlas),
			safe_tostring(tex),
			coords and safe_tostring(coords[1]) or "nil",
			coords and safe_tostring(coords[2]) or "nil",
			coords and safe_tostring(coords[3]) or "nil",
			coords and safe_tostring(coords[4]) or "nil"))
		print_line(format("PetFrameHappiness tooltips: title=%s, dmg=%s, loyalty=%s",
			safe_tostring(pfh.tooltip), safe_tostring(pfh.tooltipDamage), safe_tostring(pfh.tooltipLoyalty)))
	else
		print_line("PetFrameHappiness: nil")
	end

	local stable = _G.C_StableInfo
	if stable and type(stable.GetActivePetList) == "function" then
		local ok, list = pcall(stable.GetActivePetList)
		if ok and type(list) == "table" then
			print_line(format("C_StableInfo.GetActivePetList: count=%d", #list))
			for idx, item in ipairs(list) do
				local entry = item
				if type(item) == "number" and type(stable.GetStablePetInfo) == "function" then
					local ok2, info = pcall(stable.GetStablePetInfo, item)
					entry = (ok2 and type(info) == "table") and info or nil
				end
				if type(entry) == "table" then
					print_line(format("  [%d] name=%s, family=%s, happinessLevel=%s, loyaltyName=%s",
						idx, safe_tostring(entry.name), safe_tostring(entry.familyName),
						safe_tostring(entry.happinessLevel), safe_tostring(entry.loyaltyName)))
				end
			end
		else
			print_line(format("C_StableInfo.GetActivePetList: ok=%s, res=%s", safe_tostring(ok), safe_tostring(list)))
		end
	else
		print_line("C_StableInfo.GetActivePetList: nil")
	end

	local tier, _, _, tex, is_atlas, _, tip_title = get_happiness_info()
	local first_pet_frame
	for frame in PitBull4:IterateFramesForUnitID("pet", true) do
		first_pet_frame = frame
		break
	end
	local db = first_pet_frame and PitBull4_HappinessIcon:GetLayoutDB(first_pet_frame)
	print_line(format("Resolved: tier=%s, tex=%s, is_atlas=%s, title=%s, only_happiness_pets=%s, can_show=%s",
		safe_tostring(tier), safe_tostring(tex), safe_tostring(is_atlas), safe_tostring(tip_title),
		db and safe_tostring(db.only_happiness_pets) or "no_pet_frame",
		safe_tostring(can_pet_have_happiness(db, tex))))
end
