local PitBull4 = _G.PitBull4
local L = PitBull4.L

local PitBull4_CapsuleSkin = PitBull4:NewModule("CapsuleSkin")

PitBull4_CapsuleSkin:SetModuleType("custom")
PitBull4_CapsuleSkin:SetName(L["Capsule Skin"])
PitBull4_CapsuleSkin:SetDescription(L["Uses MaskTexture to clip unit bars, backgrounds, and 2D portraits into pill/capsule shapes with optional Blizzard elite/rare dragon overlays."])
PitBull4_CapsuleSkin:SetDefaults({
	enabled = true,
	shape = "capsule",
	mask_portrait = true,
	floating_portrait = true,
	portrait_scale = 1.10,
	portrait_x = 0,
	portrait_y = 0,
	portrait_border = false,
	border_enabled = true,
	hide_square_border = true,
	elite_dragon = true,
	dragon_style = "auto",
	player_dragon = true,
	dragon_scale = 1.0,
	dragon_x = 0,
	dragon_y = 0,
	dragon_flip = false,
	elite_border_tint = false,
	border_thickness = "normal",
	border_offset = 2,
	border_color = { 0.78, 0.82, 0.88, 0.95 },
})

local TEX_PATH = [[Interface\AddOns\PitBull4\Modules\CapsuleSkin\textures\]]

local SHAPES = {
	capsule = {
		mask = TEX_PATH .. "capsule_mask",
		border = TEX_PATH .. "capsule_border",
		border_thin = TEX_PATH .. "capsule_border_thin",
		border_thick = TEX_PATH .. "capsule_border_thick",
	},
	soft_capsule = {
		mask = TEX_PATH .. "soft_capsule_mask",
		border = TEX_PATH .. "soft_capsule_border",
		border_thin = TEX_PATH .. "soft_capsule_border_thin",
		border_thick = TEX_PATH .. "soft_capsule_border_thick",
	},
	left_cap = {
		mask = TEX_PATH .. "left_cap_mask",
		border = TEX_PATH .. "left_cap_border",
		border_thin = TEX_PATH .. "left_cap_border_thin",
		border_thick = TEX_PATH .. "left_cap_border_thick",
	},
	right_cap = {
		mask = TEX_PATH .. "right_cap_mask",
		border = TEX_PATH .. "right_cap_border",
		border_thin = TEX_PATH .. "right_cap_border_thin",
		border_thick = TEX_PATH .. "right_cap_border_thick",
	},
}

local CIRCLE_MASK = TEX_PATH .. "circle_mask"
local CIRCLE_BORDER = TEX_PATH .. "circle_border"

local BAR_KEYS = {
	"HealthBar",
	"PowerBar",
	"CastBar",
	"AltManaBar",
	"AltPowerBar",
	"ExperienceBar",
	"ReputationBar",
	"ThreatBar",
}

local DRAGON_ATLASES = {
	worldboss = {
		"UI-HUD-UnitFrame-Target-PortraitOn-Boss-Gold-Winged",
		"UI-HUD-UnitFrame-Target-PortraitOn-Boss-Gold",
	},
	elite = {
		"UI-HUD-UnitFrame-Target-PortraitOn-Boss-Gold",
		"UI-HUD-UnitFrame-Target-PortraitOn-Boss-Gold-Winged",
	},
	rareelite = {
		"UI-HUD-UnitFrame-Target-PortraitOn-Boss-Rare-Silver",
		"UI-HUD-UnitFrame-Target-PortraitOn-Boss-Silver",
	},
	rare = {
		"UI-HUD-UnitFrame-Target-PortraitOn-Boss-Silver",
		"UI-HUD-UnitFrame-Target-PortraitOn-Boss-Rare-Silver",
	},
}

local DRAGON_FALLBACK_TEX = {
	worldboss = [[Interface\TargetingFrame\UI-TargetingFrame-Elite]],
	elite = [[Interface\TargetingFrame\UI-TargetingFrame-Elite]],
	rareelite = [[Interface\TargetingFrame\UI-TargetingFrame-Rare-Elite]],
	rare = [[Interface\TargetingFrame\UI-TargetingFrame-Rare]],
}

local ELITE_BORDER_TINTS = {
	worldboss = { 1.0, 0.82, 0.18, 1.0 },
	elite = { 1.0, 0.82, 0.18, 1.0 },
	rareelite = { 0.82, 0.88, 0.98, 1.0 },
	rare = { 0.82, 0.88, 0.98, 1.0 },
}

local function apply_mask(tex, mask)
	if not tex or not tex.AddMaskTexture then return end
	if tex._pb4_capsule_mask == mask then
		if not tex.GetNumMaskTextures or tex:GetNumMaskTextures() > 0 then
			return
		end
	elseif tex._pb4_capsule_mask and tex.RemoveMaskTexture then
		tex:RemoveMaskTexture(tex._pb4_capsule_mask)
	end
	tex:AddMaskTexture(mask)
	tex._pb4_capsule_mask = mask
end

local function remove_mask(tex)
	if not tex or not tex._pb4_capsule_mask then return end
	if tex.RemoveMaskTexture then
		tex:RemoveMaskTexture(tex._pb4_capsule_mask)
	end
	tex._pb4_capsule_mask = nil
end

local function apply_bar_mask(bar, mask)
	if not bar then return end
	if bar.GetStatusBarTexture then
		apply_mask(bar:GetStatusBarTexture(), mask)
	end
	apply_mask(bar.fg, mask)
	apply_mask(bar.bg, mask)
	apply_mask(bar.extra, mask)
	apply_mask(bar.extra2, mask)
end

local function clear_bar_mask(bar)
	if not bar then return end
	if bar.GetStatusBarTexture then
		remove_mask(bar:GetStatusBarTexture())
	end
	remove_mask(bar.fg)
	remove_mask(bar.bg)
	remove_mask(bar.extra)
	remove_mask(bar.extra2)
end

local function restore_square_border(frame)
	if frame.Border and frame._pb4_hid_square_border then
		frame.Border:SetAlpha(1)
		frame.Border:Show()
		frame._pb4_hid_square_border = nil
	end
end

local function is_portrait_on_left(frame, portrait)
	local portrait_mod = PitBull4:GetModule("Portrait", true)
	if portrait_mod and portrait_mod.db and frame.layout then
		local pdb = portrait_mod:GetLayoutDB(frame)
		if pdb and pdb.side == "right" then
			return false
		elseif pdb and pdb.side == "left" then
			return true
		end
	end
	local fx = frame:GetCenter()
	local px = portrait:GetCenter()
	if fx and px then
		return px < fx
	end
	return false
end

local function resolve_dragon_classification(frame, db)
	if not db.elite_dragon then
		return nil
	end
	local style = db.dragon_style or "auto"
	if style == "none" then
		return nil
	elseif style == "gold" then
		return "elite"
	elseif style == "winged_gold" then
		return "worldboss"
	elseif style == "silver" then
		return "rare"
	end
	local classification = frame.unit and PitBull4.Utils.BetterUnitClassification(frame.unit)
	if classification and DRAGON_FALLBACK_TEX[classification] then
		return classification
	end
	if db.player_dragon and frame.unit == "player" then
		return "elite"
	end
	return nil
end

local function resolve_dragon_atlas(classification)
	local candidates = DRAGON_ATLASES[classification]
	if not candidates or not C_Texture or not C_Texture.GetAtlasInfo then
		return nil
	end
	for _, atlas in ipairs(candidates) do
		if C_Texture.GetAtlasInfo(atlas) then
			return atlas
		end
	end
	return nil
end

function PitBull4_CapsuleSkin:ApplyFloatingLayout(frame)
	if not frame or not frame.layout then return end
	local db = self:GetLayoutDB(frame)
	local portrait = frame.Portrait
	if not (db.enabled and db.shape ~= "none" and db.floating_portrait and portrait and portrait:IsShown()) then
		return
	end

	-- Extend center bars behind the portrait using plain coordinates saved in UnitFrameLayout
	-- Texts remain anchored to bar._pb4_text_anchor so they never move and never trigger secret-value GetPoint
	local pad = (frame.layout_db and frame.layout_db.bar_padding) or 2
	for _, key in ipairs(BAR_KEYS) do
		local bar = frame[key]
		if bar and bar._pb4_orig_top and bar._pb4_orig_bottom then
			bar:ClearAllPoints()
			bar:SetPoint("TOPLEFT", frame, "TOPLEFT", pad, bar._pb4_orig_top)
			bar:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -pad, bar._pb4_orig_bottom)
		end
	end

	local fh = frame:GetHeight() or 40
	local d = math.max(fh * (db.portrait_scale or 1.10), 18)
	local side_left = is_portrait_on_left(frame, portrait)
	local px = db.portrait_x or 0
	local py = db.portrait_y or 0

	-- Reset scale to 1 (UnitFrameLayout sets bar_scale = bar_height / portrait:GetHeight() which would cancel out d!)
	portrait:SetScale(1)
	portrait:SetFrameLevel(frame:GetFrameLevel() + 11)
	if portrait.model then
		portrait.model:SetScale(1)
		portrait.model:SetFrameLevel(frame:GetFrameLevel() + 11)
	end
	portrait:ClearAllPoints()
	portrait:SetSize(d, d)
	if side_left then
		portrait:SetPoint("CENTER", frame, "LEFT", fh * 0.38 + px, py)
	else
		portrait:SetPoint("CENTER", frame, "RIGHT", -fh * 0.38 + px, py)
	end
	if portrait.texture then
		portrait.texture:ClearAllPoints()
		portrait.texture:SetAllPoints(portrait)
	end
end

function PitBull4_CapsuleSkin:ApplyPortraitMask(frame)
	if not frame or not frame.layout then return end
	local db = self:GetLayoutDB(frame)
	local portrait = frame.Portrait
	if not portrait then return end

	if db.enabled and db.shape ~= "none" and db.mask_portrait and portrait.texture and frame.CreateMaskTexture then
		-- Own the MaskTexture on `frame` (not `portrait`, which is recycled on style switch)
		if not frame.CapsulePortraitMask then
			frame.CapsulePortraitMask = frame:CreateMaskTexture()
		end
		local pmask = frame.CapsulePortraitMask
		pmask:SetTexture(CIRCLE_MASK, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
		pmask:ClearAllPoints()
		pmask:SetAllPoints(portrait)
		if portrait.style == "two_dimensional" then
			-- Restore full Blizzard chest-up portrait framing instead of PitBull4's tight 0.146..0.853 square crop
			portrait.texture:SetTexCoord(0.02, 0.98, 0.02, 0.98)
		end
		apply_mask(portrait.texture, pmask)
		apply_mask(portrait.bg, pmask)

		if db.floating_portrait then
			if not portrait._pb4_circle_bg then
				local cbg = portrait:CreateTexture(nil, "BACKGROUND")
				cbg:SetAllPoints(portrait)
				cbg:SetColorTexture(0.04, 0.04, 0.06, 1.0)
				portrait._pb4_circle_bg = cbg
			end
			apply_mask(portrait._pb4_circle_bg, pmask)
			portrait._pb4_circle_bg:Show()
			if portrait.bg then
				portrait.bg:Hide()
			end
		else
			if portrait._pb4_circle_bg then
				portrait._pb4_circle_bg:Hide()
			end
			if portrait.bg then
				portrait.bg:Show()
			end
		end

		local has_dragon = db.elite_dragon and resolve_dragon_classification(frame, db) and DRAGON_FALLBACK_TEX[resolve_dragon_classification(frame, db)]
		if db.portrait_border or (db.floating_portrait and not has_dragon) then
			if not portrait._pb4_circle_border then
				local pborder = portrait:CreateTexture(nil, "OVERLAY")
				pborder:SetPoint("TOPLEFT", portrait, "TOPLEFT", -2, 2)
				pborder:SetPoint("BOTTOMRIGHT", portrait, "BOTTOMRIGHT", 2, -2)
				portrait._pb4_circle_border = pborder
			end
			portrait._pb4_circle_border:SetTexture(CIRCLE_BORDER)
			local r, g, b, a = unpack(db.border_color)
			portrait._pb4_circle_border:SetVertexColor(r, g, b, a)
			portrait._pb4_circle_border:Show()
		elseif portrait._pb4_circle_border then
			portrait._pb4_circle_border:Hide()
		end
	else
		remove_mask(portrait.texture)
		remove_mask(portrait.bg)
		if portrait._pb4_circle_bg then
			portrait._pb4_circle_bg:Hide()
		end
		if portrait.bg then
			portrait.bg:Show()
		end
		if portrait._pb4_circle_border then
			portrait._pb4_circle_border:Hide()
		end
	end
end

function PitBull4_CapsuleSkin:UpdateDragon(frame)
	if not frame or not frame.layout then return end
	local db = self:GetLayoutDB(frame)
	local portrait = frame.Portrait
	local classification = resolve_dragon_classification(frame, db)
	if portrait and not portrait._pb4_dragon_size_hooked then
		portrait._pb4_dragon_size_hooked = true
		portrait:HookScript("OnSizeChanged", function(p)
			local owner = p:GetParent()
			if owner and owner.layout and self:IsEnabled() and owner:IsShown() then
				self:UpdateDragon(owner)
			end
		end)
	end

	local has_dragon = db.enabled and db.shape ~= "none" and portrait and portrait:IsShown() and classification and DRAGON_FALLBACK_TEX[classification]

	if not has_dragon then
		if frame.CapsuleEliteDragon then
			frame.CapsuleEliteDragon:Hide()
		end
		return
	end

	if not frame.CapsuleEliteDragon then
		local holder = CreateFrame("Frame", nil, frame)
		local tex = holder:CreateTexture(nil, "OVERLAY", nil, 7)
		holder.tex = tex
		frame.CapsuleEliteDragon = holder
	end

	local holder = frame.CapsuleEliteDragon
	-- Place dragon above CapsuleSkinBorder (N+10) but below Indicator icons (N+13) and overlay texts (N+17)
	holder:SetFrameLevel(frame:GetFrameLevel() + 12)
	local tex = holder.tex
	if not frame:GetCenter() or not portrait:GetCenter() then
		if not frame._pb4_dragon_retry and C_Timer and C_Timer.After then
			frame._pb4_dragon_retry = true
			C_Timer.After(0, function()
				frame._pb4_dragon_retry = nil
				if self:IsEnabled() and frame:IsShown() then
					self:UpdateDragon(frame)
				end
			end)
		end
	end
	local on_left = is_portrait_on_left(frame, portrait)
	local mirror_left = db.dragon_flip and (not on_left) or on_left
	local size = math.max(frame:GetHeight() or 40, 24)

	holder:ClearAllPoints()
	tex:ClearAllPoints()

	local atlas = resolve_dragon_atlas(classification)
	local d_scale = db.dragon_scale or 1.0
	local ox = db.dragon_x or 0
	local oy = db.dragon_y or 0
	if atlas then
		if tex._pb4_last_atlas ~= atlas or tex._pb4_last_mirror_left ~= mirror_left then
			local info = C_Texture and C_Texture.GetAtlasInfo and C_Texture.GetAtlasInfo(atlas)
			local tex_file = info and (info.file or info.filename)
			if tex_file then
				-- Use underlying texture file + explicit atlas UVs so SetTexCoord mirroring is never overridden by SetAtlas
				tex:SetTexture(nil)
				tex:SetTexture(tex_file)
				tex:SetHorizTile(false)
				tex:SetVertTile(false)
				if mirror_left then
					tex:SetTexCoord(info.rightTexCoord, info.leftTexCoord, info.topTexCoord, info.bottomTexCoord)
				else
					tex:SetTexCoord(info.leftTexCoord, info.rightTexCoord, info.topTexCoord, info.bottomTexCoord)
				end
			else
				tex:SetTexture(nil)
				tex:SetTexCoord(0, 1, 0, 1)
				tex:SetAtlas(atlas, false)
				if mirror_left then
					local ULx, ULy, LLx, LLy, URx, URy, LRx, LRy = tex:GetTexCoord()
					tex:SetTexCoord(URx, URy, LRx, LRy, ULx, ULy, LLx, LLy)
				end
			end
			tex._pb4_last_atlas = atlas
			tex._pb4_last_mirror_left = mirror_left
		end
		local w = size * 1.65 * d_scale
		local h = size * 1.65 * d_scale
		holder:SetSize(w, h)
		if on_left then
			holder:SetPoint("CENTER", portrait, "CENTER", -size * 0.14 * d_scale + ox, oy)
		else
			holder:SetPoint("CENTER", portrait, "CENTER", size * 0.14 * d_scale + ox, oy)
		end
		tex:SetAllPoints(holder)
	else
		tex._pb4_last_atlas = nil
		tex._pb4_last_mirror_left = nil
		tex:SetTexture(DRAGON_FALLBACK_TEX[classification])
		local w = size * 1.75 * d_scale
		local h = size * 1.75 * d_scale
		holder:SetSize(w, h)
		if on_left then
			holder:SetPoint("CENTER", portrait, "CENTER", -size * 0.18 * d_scale + ox, -size * 0.04 * d_scale + oy)
		else
			holder:SetPoint("CENTER", portrait, "CENTER", size * 0.18 * d_scale + ox, -size * 0.04 * d_scale + oy)
		end
		if mirror_left then
			tex:SetTexCoord(0.96, 0.48, 0.02, 0.78)
		else
			tex:SetTexCoord(0.48, 0.96, 0.02, 0.78)
		end
		tex:SetAllPoints(holder)
	end

	holder:Show()
end

function PitBull4_CapsuleSkin:ClearFrame(frame)
	remove_mask(frame.Background)
	for _, key in ipairs(BAR_KEYS) do
		clear_bar_mask(frame[key])
	end
	if frame.Portrait then
		remove_mask(frame.Portrait.texture)
		remove_mask(frame.Portrait.bg)
		if frame.Portrait._pb4_circle_bg then
			frame.Portrait._pb4_circle_bg:Hide()
		end
		if frame.Portrait.bg then
			frame.Portrait.bg:Show()
		end
		if frame.Portrait._pb4_circle_border then
			frame.Portrait._pb4_circle_border:Hide()
		end
	end
	restore_square_border(frame)
	if frame.CapsuleSkinBorder then
		frame.CapsuleSkinBorder:Hide()
	end
	if frame.CapsuleEliteDragon then
		frame.CapsuleEliteDragon:Hide()
	end
	return false
end

function PitBull4_CapsuleSkin:OnHide(frame)
	if frame.CapsuleSkinBorder then
		frame.CapsuleSkinBorder:Hide()
	end
	if frame.CapsuleEliteDragon then
		frame.CapsuleEliteDragon:Hide()
	end
end

function PitBull4_CapsuleSkin:UpdateFrame(frame)
	if not frame or not frame.layout then return false end
	local db = self:GetLayoutDB(frame)
	if not db.enabled or db.shape == "none" or not SHAPES[db.shape] then
		self:ClearFrame(frame)
		return false
	end

	local shape_info = SHAPES[db.shape]

	if db.hide_square_border and frame.Border then
		frame.Border:SetAlpha(0)
		frame.Border:Hide()
		frame._pb4_hid_square_border = true
	else
		restore_square_border(frame)
	end

	if not frame.CapsuleSkinMask and frame.CreateMaskTexture then
		frame.CapsuleSkinMask = frame:CreateMaskTexture()
	end

	local mask = frame.CapsuleSkinMask
	if mask then
		mask:SetTexture(shape_info.mask, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
		mask:ClearAllPoints()
		mask:SetPoint("TOPLEFT", frame, "TOPLEFT", -1, 1)
		mask:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 1, -1)

		apply_mask(frame.Background, mask)
		for _, key in ipairs(BAR_KEYS) do
			apply_bar_mask(frame[key], mask)
		end
	end

	self:ApplyFloatingLayout(frame)
	self:ApplyPortraitMask(frame)
	self:UpdateDragon(frame)

	if db.border_enabled then
		if not frame.CapsuleBorderFrame then
			local bframe = CreateFrame("Frame", nil, frame)
			bframe:SetFrameLevel(frame:GetFrameLevel() + 10)
			local border = bframe:CreateTexture(nil, "OVERLAY")
			frame.CapsuleBorderFrame = bframe
			frame.CapsuleSkinBorder = border
		end
		frame.CapsuleBorderFrame:SetFrameLevel(frame:GetFrameLevel() + 10)
		local off = db.border_offset
		if off == nil then off = 2 end
		frame.CapsuleSkinBorder:ClearAllPoints()
		frame.CapsuleSkinBorder:SetPoint("TOPLEFT", frame, "TOPLEFT", -off, off)
		frame.CapsuleSkinBorder:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", off, -off)

		local btex = shape_info.border
		if db.border_thickness == "thin" then
			btex = shape_info.border_thin
		elseif db.border_thickness == "thick" then
			btex = shape_info.border_thick
		end
		frame.CapsuleSkinBorder:SetTexture(btex)
		local classification = resolve_dragon_classification(frame, db)
		local tint = db.elite_border_tint and classification and ELITE_BORDER_TINTS[classification]
		local r, g, b, a = unpack(tint or db.border_color)
		frame.CapsuleSkinBorder:SetVertexColor(r, g, b, a)
		frame.CapsuleSkinBorder:Show()
	elseif frame.CapsuleSkinBorder then
		frame.CapsuleSkinBorder:Hide()
	end

	return false
end

function PitBull4_CapsuleSkin:OnEnable()
	if not self._portrait_hooked then
		local portrait_mod = PitBull4:GetModule("Portrait", true)
		if portrait_mod then
			self._portrait_hooked = true
			hooksecurefunc(portrait_mod, "ClearFrame", function(_, frame)
				if frame and frame.Portrait then
					remove_mask(frame.Portrait.texture)
					remove_mask(frame.Portrait.bg)
					if frame.Portrait._pb4_circle_border then
						frame.Portrait._pb4_circle_border:Hide()
					end
				end
				if frame and frame.CapsuleEliteDragon then
					frame.CapsuleEliteDragon:Hide()
				end
			end)
			hooksecurefunc(portrait_mod, "UpdateFrame", function(_, frame)
				if frame and frame.layout and self:IsEnabled() then
					self:ApplyFloatingLayout(frame)
					self:ApplyPortraitMask(frame)
					self:UpdateDragon(frame)
				end
			end)
		end
	end
	if not self._border_hooked then
		local border_mod = PitBull4:GetModule("Border", true)
		if border_mod then
			self._border_hooked = true
			hooksecurefunc(border_mod, "UpdateFrame", function(_, frame)
				if frame and frame.layout and self:IsEnabled() and frame.Border then
					local db = self:GetLayoutDB(frame)
					if db and db.enabled and db.shape ~= "none" and db.hide_square_border then
						frame.Border:SetAlpha(0)
						frame.Border:Hide()
						frame._pb4_hid_square_border = true
					end
				end
			end)
		end
	end
	self:UpdateAll()
end

function PitBull4_CapsuleSkin:OnDisable()
	for frame in PitBull4:IterateFrames() do
		self:ClearFrame(frame)
	end
end

function PitBull4_CapsuleSkin:GetPortraitLayoutOptions()
	local capsule = self
	local function capsule_hidden()
		return not capsule:IsEnabled()
	end
	local function capsule_disabled()
		return not capsule:IsEnabled() or not PitBull4.Options.GetLayoutDB(capsule).enabled
	end

	return 'capsule_portrait_header', {
		type = 'header',
		name = L["Capsule portrait & dragon"],
		hidden = capsule_hidden,
		order = 150,
	},
	'mask_portrait', {
		type = 'toggle',
		name = L["Circular 2D portrait mask"],
		desc = L["Clip 2D or class portraits into a circle (3D models cannot be clipped by MaskTexture)."],
		get = function(info)
			return PitBull4.Options.GetLayoutDB(capsule).mask_portrait
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(capsule).mask_portrait = value
			PitBull4.Options.UpdateFrames(capsule)
		end,
		hidden = capsule_hidden,
		disabled = capsule_disabled,
		order = 151,
	},
	'portrait_border', {
		type = 'toggle',
		name = L["Portrait ring border"],
		desc = L["Draw an extra circular border ring around the 2D portrait (off by default to avoid overlapping the capsule border)."],
		get = function(info)
			return PitBull4.Options.GetLayoutDB(capsule).portrait_border
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(capsule).portrait_border = value
			PitBull4.Options.UpdateFrames(capsule)
		end,
		hidden = capsule_hidden,
		disabled = function(info)
			return capsule_disabled() or not PitBull4.Options.GetLayoutDB(capsule).mask_portrait
		end,
		order = 152,
	},
	'floating_portrait', {
		type = 'toggle',
		name = L["Floating circular portrait"],
		desc = L["Extend bars 100% behind the portrait and float the circular portrait on top (Blizzard-style chest-up framing)."],
		get = function(info)
			return PitBull4.Options.GetLayoutDB(capsule).floating_portrait
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(capsule).floating_portrait = value
			local layout = PitBull4.Options.GetCurrentLayout()
			for frame in PitBull4:IterateFramesForLayout(layout) do
				frame:UpdateLayout(false)
			end
			PitBull4.Options.UpdateFrames(capsule)
		end,
		hidden = capsule_hidden,
		disabled = capsule_disabled,
		order = 153,
	},
	'portrait_scale', {
		type = 'range',
		name = L["Portrait diameter"],
		desc = L["Set the circular portrait diameter relative to the frame height (110% is recommended)."],
		min = 0.60,
		max = 2.00,
		step = 0.05,
		isPercent = true,
		get = function(info)
			return PitBull4.Options.GetLayoutDB(capsule).portrait_scale or 1.10
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(capsule).portrait_scale = value
			PitBull4.Options.UpdateFrames(capsule)
		end,
		hidden = capsule_hidden,
		disabled = function(info)
			return capsule_disabled() or not PitBull4.Options.GetLayoutDB(capsule).floating_portrait
		end,
		order = 154,
	},
	'portrait_x', {
		type = 'range',
		name = L["Portrait X offset"],
		desc = L["Fine-tune the horizontal position of the floating portrait."],
		min = -30,
		max = 30,
		step = 1,
		get = function(info)
			return PitBull4.Options.GetLayoutDB(capsule).portrait_x or 0
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(capsule).portrait_x = value
			PitBull4.Options.UpdateFrames(capsule)
		end,
		hidden = capsule_hidden,
		disabled = function(info)
			return capsule_disabled() or not PitBull4.Options.GetLayoutDB(capsule).floating_portrait
		end,
		order = 155,
	},
	'portrait_y', {
		type = 'range',
		name = L["Portrait Y offset"],
		desc = L["Fine-tune the vertical position of the floating portrait."],
		min = -30,
		max = 30,
		step = 1,
		get = function(info)
			return PitBull4.Options.GetLayoutDB(capsule).portrait_y or 0
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(capsule).portrait_y = value
			PitBull4.Options.UpdateFrames(capsule)
		end,
		hidden = capsule_hidden,
		disabled = function(info)
			return capsule_disabled() or not PitBull4.Options.GetLayoutDB(capsule).floating_portrait
		end,
		order = 156,
	},
	'elite_dragon', {
		type = 'toggle',
		name = L["Elite / Rare dragon overlay"],
		desc = L["Show Blizzard's gold or silver dragon frame around the portrait for elite, rare, or boss units."],
		get = function(info)
			return PitBull4.Options.GetLayoutDB(capsule).elite_dragon
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(capsule).elite_dragon = value
			PitBull4.Options.UpdateFrames(capsule)
		end,
		hidden = capsule_hidden,
		disabled = capsule_disabled,
		order = 157,
	},
	'dragon_style', {
		type = 'select',
		name = L["Dragon style"],
		desc = L["Choose automatic unit classification detection or force a specific dragon frame for this layout."],
		values = {
			auto = L["Auto (elite / rare / player)"],
			gold = L["Always gold dragon"],
			winged_gold = L["Always winged gold dragon (boss)"],
			silver = L["Always silver dragon"],
			none = L["Off"],
		},
		get = function(info)
			return PitBull4.Options.GetLayoutDB(capsule).dragon_style or "auto"
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(capsule).dragon_style = value
			PitBull4.Options.UpdateFrames(capsule)
		end,
		hidden = capsule_hidden,
		disabled = function(info)
			return capsule_disabled() or not PitBull4.Options.GetLayoutDB(capsule).elite_dragon
		end,
		order = 158,
	},
	'player_dragon', {
		type = 'toggle',
		name = L["Show gold dragon on player"],
		desc = L["When Dragon style is Auto, also display a gold dragon on the player's own portrait."],
		get = function(info)
			return PitBull4.Options.GetLayoutDB(capsule).player_dragon
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(capsule).player_dragon = value
			PitBull4.Options.UpdateFrames(capsule)
		end,
		hidden = capsule_hidden,
		disabled = function(info)
			local ldb = PitBull4.Options.GetLayoutDB(capsule)
			return capsule_disabled() or not ldb.elite_dragon or (ldb.dragon_style and ldb.dragon_style ~= "auto")
		end,
		order = 159,
	},
	'dragon_scale', {
		type = 'range',
		name = L["Dragon scale"],
		desc = L["Adjust the overall scale of the elite/rare dragon frame."],
		min = 0.5,
		max = 2.0,
		step = 0.05,
		isPercent = true,
		get = function(info)
			return PitBull4.Options.GetLayoutDB(capsule).dragon_scale or 1.0
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(capsule).dragon_scale = value
			PitBull4.Options.UpdateFrames(capsule)
		end,
		hidden = capsule_hidden,
		disabled = function(info)
			local ldb = PitBull4.Options.GetLayoutDB(capsule)
			return capsule_disabled() or not ldb.elite_dragon or ldb.dragon_style == "none"
		end,
		order = 160,
	},
	'dragon_x', {
		type = 'range',
		name = L["Dragon X offset"],
		desc = L["Fine-tune the horizontal offset of the dragon frame (positive = right, negative = left)."],
		min = -40,
		max = 40,
		step = 1,
		get = function(info)
			return PitBull4.Options.GetLayoutDB(capsule).dragon_x or 0
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(capsule).dragon_x = value
			PitBull4.Options.UpdateFrames(capsule)
		end,
		hidden = capsule_hidden,
		disabled = function(info)
			local ldb = PitBull4.Options.GetLayoutDB(capsule)
			return capsule_disabled() or not ldb.elite_dragon or ldb.dragon_style == "none"
		end,
		order = 161,
	},
	'dragon_y', {
		type = 'range',
		name = L["Dragon Y offset"],
		desc = L["Fine-tune the vertical offset of the dragon frame (positive = up, negative = down)."],
		min = -40,
		max = 40,
		step = 1,
		get = function(info)
			return PitBull4.Options.GetLayoutDB(capsule).dragon_y or 0
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(capsule).dragon_y = value
			PitBull4.Options.UpdateFrames(capsule)
		end,
		hidden = capsule_hidden,
		disabled = function(info)
			local ldb = PitBull4.Options.GetLayoutDB(capsule)
			return capsule_disabled() or not ldb.elite_dragon or ldb.dragon_style == "none"
		end,
		order = 162,
	},
	'dragon_flip', {
		type = 'toggle',
		name = L["Flip dragon horizontally"],
		desc = L["Mirror the dragon frame left/right if its facing direction is reversed."],
		get = function(info)
			return PitBull4.Options.GetLayoutDB(capsule).dragon_flip
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(capsule).dragon_flip = value
			PitBull4.Options.UpdateFrames(capsule)
		end,
		hidden = capsule_hidden,
		disabled = function(info)
			local ldb = PitBull4.Options.GetLayoutDB(capsule)
			return capsule_disabled() or not ldb.elite_dragon or ldb.dragon_style == "none"
		end,
		order = 163,
	}
end

PitBull4_CapsuleSkin:SetLayoutOptionsFunction(function(self)
	return 'shape', {
		type = 'select',
		name = L["Frame shape"],
		desc = L["Select the capsule or rounded clipping shape for this layout. Use Soft Capsule if corner texts overlap the border."],
		values = {
			capsule = L["Full capsule (semicircle ends)"],
			soft_capsule = L["Soft capsule (text-safe corners)"],
			left_cap = L["Left semicircle + right rounded"],
			right_cap = L["Left rounded + right semicircle"],
			none = L["Off (rectangular)"],
		},
		get = function(info)
			return PitBull4.Options.GetLayoutDB(self).shape
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(self).shape = value
			PitBull4.Options.UpdateFrames(self)
		end,
		order = 1,
	},
	'hide_square_border', {
		type = 'toggle',
		name = L["Hide square border"],
		desc = L["Automatically hide PitBull4's default square border when capsule skin is active."],
		get = function(info)
			return PitBull4.Options.GetLayoutDB(self).hide_square_border
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(self).hide_square_border = value
			PitBull4.Options.UpdateFrames(self)
		end,
		order = 2,
	},
	'elite_border_tint', {
		type = 'toggle',
		name = L["Tint border by classification"],
		desc = L["Automatically tint the capsule border gold for elites/bosses and silver for rares."],
		get = function(info)
			return PitBull4.Options.GetLayoutDB(self).elite_border_tint
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(self).elite_border_tint = value
			PitBull4.Options.UpdateFrames(self)
		end,
		disabled = function(info)
			return not PitBull4.Options.GetLayoutDB(self).border_enabled
		end,
		order = 11,
	},
	'border_enabled', {
		type = 'toggle',
		name = L["Show capsule border"],
		desc = L["Draw a metallic capsule border around the frame."],
		get = function(info)
			return PitBull4.Options.GetLayoutDB(self).border_enabled
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(self).border_enabled = value
			PitBull4.Options.UpdateFrames(self)
		end,
		order = 12,
	},
	'border_thickness', {
		type = 'select',
		name = L["Border thickness"],
		desc = L["Select the stroke thickness of the capsule border (Thin is recommended for small frames)."],
		values = {
			thin = L["Thin"],
			normal = L["Normal"],
			thick = L["Thick"],
		},
		get = function(info)
			return PitBull4.Options.GetLayoutDB(self).border_thickness or "normal"
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(self).border_thickness = value
			PitBull4.Options.UpdateFrames(self)
		end,
		disabled = function(info)
			return not PitBull4.Options.GetLayoutDB(self).border_enabled
		end,
		order = 13,
	},
	'border_offset', {
		type = 'range',
		name = L["Border gap"],
		desc = L["Adjust the outward padding between the bars and the capsule border (0 or -1 hugs small frames tightly)."],
		min = -3,
		max = 8,
		step = 0.5,
		get = function(info)
			local v = PitBull4.Options.GetLayoutDB(self).border_offset
			return v ~= nil and v or 2
		end,
		set = function(info, value)
			PitBull4.Options.GetLayoutDB(self).border_offset = value
			PitBull4.Options.UpdateFrames(self)
		end,
		disabled = function(info)
			return not PitBull4.Options.GetLayoutDB(self).border_enabled
		end,
		order = 14,
	},
	'border_color', {
		type = 'color',
		name = L["Capsule border color"],
		desc = L["Set the color and opacity of the capsule border."],
		hasAlpha = true,
		get = function(info)
			return unpack(PitBull4.Options.GetLayoutDB(self).border_color)
		end,
		set = function(info, r, g, b, a)
			local c = PitBull4.Options.GetLayoutDB(self).border_color
			c[1], c[2], c[3], c[4] = r, g, b, a
			PitBull4.Options.UpdateFrames(self)
		end,
		disabled = function(info)
			return not PitBull4.Options.GetLayoutDB(self).border_enabled
		end,
		order = 15,
	}
end)
