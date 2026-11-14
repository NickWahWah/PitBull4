local PitBull4 = _G.PitBull4
local PitBull4_Aura = PitBull4:GetModule("Aura")

local function get_growth_params(growth)
	-- Returns axis, growthX, growthY, flowAnchor
	if growth == "left_down" then
		return "H", -1, -1, "TOPRIGHT"
	elseif growth == "left_up" then
		return "H", -1, 1, "BOTTOMRIGHT"
	elseif growth == "right_up" then
		return "H", 1, 1, "BOTTOMLEFT"
	elseif growth == "down_right" then
		return "V", 1, -1, "TOPLEFT"
	elseif growth == "down_left" then
		return "V", -1, -1, "TOPRIGHT"
	elseif growth == "up_right" then
		return "V", 1, 1, "BOTTOMLEFT"
	elseif growth == "up_left" then
		return "V", -1, 1, "BOTTOMRIGHT"
	end
	-- default: "right_down"
	return "H", 1, -1, "TOPLEFT"
end

local function get_anchor_points(anchor, side)
	-- Map PitBull4's (anchor, side) to (containerPoint, framePoint)
	if side == "TOP" then
		if anchor == "TOPRIGHT" then
			return "BOTTOMRIGHT", "TOPRIGHT"
		end
		return "BOTTOMLEFT", "TOPLEFT"
	elseif side == "LEFT" then
		if anchor == "BOTTOMLEFT" then
			return "BOTTOMRIGHT", "BOTTOMLEFT"
		end
		return "TOPRIGHT", "TOPLEFT"
	elseif side == "RIGHT" then
		if anchor == "BOTTOMRIGHT" then
			return "BOTTOMLEFT", "BOTTOMRIGHT"
		end
		return "TOPLEFT", "TOPRIGHT"
	end
	-- default side == "BOTTOM"
	if anchor == "BOTTOMRIGHT" then
		return "TOPRIGHT", "BOTTOMRIGHT"
	end
	return "TOPLEFT", "BOTTOMLEFT"
end

local function apply_button_style(button, size, frame)
	if not button then return end
	if button.IsForbidden and button:IsForbidden() then return end
	if button._pb4_styled_size == size then return end

	local ok = pcall(button.SetSize, button, size, size)
	if not ok then return end
	button._pb4_styled_size = size

	local font_path = GameFontNormal and select(1, GameFontNormal:GetFont()) or STANDARD_TEXT_FONT
	local time_size = math.max(9, math.floor(size * 0.42))
	local count_size = math.max(9, math.floor(size * 0.45))

	if button.Time and not (button.Time.IsForbidden and button.Time:IsForbidden()) then
		pcall(button.Time.SetFont, button.Time, font_path, time_size, "OUTLINE")
	end
	if button.Count and not (button.Count.IsForbidden and button.Count:IsForbidden()) then
		pcall(button.Count.SetFont, button.Count, font_path, count_size, "OUTLINE")
	end
end

local function create_aura_button_init(container, is_buff, frame)
	return function(button)
		local size = container._pb4_size or 20
		button:SetSize(size, size)
		button:EnableMouse(true)

		if button.SetTooltipAnchorPoint then
			button:SetTooltipAnchorPoint("ANCHOR_BOTTOMLEFT", 0, 0)
		end
		if button.SetHideTooltipInCombat then
			button:SetHideTooltipInCombat(false)
		end

		local cooldown = CreateFrame("Cooldown", nil, button, "CooldownFrameTemplate")
		cooldown:SetAllPoints()
		button.Cooldown = cooldown
		if button.SetDurationCooldown then
			button:SetDurationCooldown(cooldown)
		end

		local icon = button:CreateTexture(nil, "BORDER")
		icon:SetAllPoints()
		icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
		button.Icon = icon
		if button.SetIcon then
			button:SetIcon(icon)
		end

		local textParent = CreateFrame("Frame", nil, button)
		textParent:SetAllPoints()
		textParent:SetFrameLevel(cooldown:GetFrameLevel() + 1)

		local count = textParent:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
		count:SetPoint("BOTTOMRIGHT", -1, 1)
		button.Count = count
		if button.SetApplicationCount then
			button:SetApplicationCount(count)
		end

		local show_builtin_cd = _G.OmniCC ~= nil or (GetCVarBool and GetCVarBool("countdownForCooldowns"))
		local time = textParent:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
		time:SetPoint("CENTER", 0, 0)
		button.Time = time
		if show_builtin_cd then
			time:Hide()
		else
			cooldown:SetHideCountdownNumbers(true)
			cooldown.noCooldownCount = true
			if button.SetDurationText then
				button:SetDurationText(time)
			end
		end

		apply_button_style(button, size, frame)

		if button.AddDispelTypeTexture then
			local style_enum = _G.Enum and _G.Enum.CustomAuraButtonDispelTypeTextureStyle
			local steal_enum = _G.Enum and _G.Enum.CustomAuraButtonDispelTypeStealableFilter

			if not is_buff and style_enum and style_enum.Border then
				local border = button:CreateTexture(nil, "OVERLAY")
				border:SetAllPoints()
				button.Border = border
				button:AddDispelTypeTexture(border, {
					style = style_enum.Border,
					showWhenHarmful = true,
					showWhenHelpful = false,
				})
			elseif is_buff and style_enum and style_enum.PreserveAsset and steal_enum and steal_enum.Stealable then
				local stealable = button:CreateTexture(nil, "OVERLAY")
				stealable:SetPoint("TOPLEFT", -3, 3)
				stealable:SetPoint("BOTTOMRIGHT", 3, -3)
				stealable:SetTexture([[Interface\TargetingFrame\UI-TargetingFrame-Stealable]])
				stealable:SetBlendMode("ADD")
				button.Stealable = stealable
				button:AddDispelTypeTexture(stealable, {
					style = style_enum.PreserveAsset,
					showWhenHelpful = true,
					showWithoutDispelType = true,
					stealableFilter = steal_enum.Stealable,
				})
			end
		end
	end
end

local function configure_container_layout(container, frame, db, is_buff)
	local layout_db = is_buff and db.layout.buff or db.layout.debuff
	local size = math.max(layout_db.size or 16, layout_db.my_size or 0)
	if size < 8 then size = 16 end

	local frame_width = frame:GetWidth()
	if not frame_width or frame_width < 40 then frame_width = 220 end
	local max_width
	if layout_db.width_type == "fixed" and layout_db.width then
		max_width = layout_db.width
	else
		max_width = frame_width * (layout_db.width_percent or 0.5)
	end
	max_width = math.max(max_width, size * 4)

	local col_spacing = layout_db.col_spacing or 2
	local row_spacing = layout_db.row_spacing or 2
	if col_spacing < 1 then col_spacing = 2 end
	if row_spacing < 1 then row_spacing = 2 end

	local default_anchor = is_buff and "BOTTOMLEFT" or "BOTTOMRIGHT"
	local default_growth = is_buff and "right_down" or "left_down"
	local anchor = layout_db.anchor or default_anchor
	local side = layout_db.side or "BOTTOM"
	local growth = layout_db.growth or default_growth
	local offset_x = layout_db.offset_x or 0
	local offset_y = (layout_db.offset_y or 0) + (side == "BOTTOM" and -2 or (side == "TOP" and 2 or 0))

	local my_point, frame_point = get_anchor_points(anchor, side)
	local axis_kind, gx, gy, flow_anchor = get_growth_params(growth)

	container._pb4_size = size
	container:SetSize(max_width, size * 3 + row_spacing * 2)
	container:ClearAllPoints()
	container:SetPoint(my_point, frame, frame_point, offset_x, offset_y)

	if _G.AnchorUtil and _G.AnchorUtil.FlowLayoutAxis and container.SetFlowLayoutAxis then
		local axis_val = (axis_kind == "V")
			and _G.AnchorUtil.FlowLayoutAxis.Vertical
			or _G.AnchorUtil.FlowLayoutAxis.Horizontal
		container:SetFlowLayoutAxis(axis_val)
	end
	if container.SetFlowLayoutAnchorPoint then
		container:SetFlowLayoutAnchorPoint(flow_anchor)
	end
	if container.SetFlowLayoutGrowthDirection then
		container:SetFlowLayoutGrowthDirection(gx, gy)
	end
	if container.SetFlowLayoutMaximumLineSize then
		container:SetFlowLayoutMaximumLineSize(max_width)
	end
	if container.SetFlowLayoutPadding then
		container:SetFlowLayoutPadding(0, 0, 0, 0)
	end

	-- Resize any already-created child aura buttons when user tweaks PitBull4 options
	for i = 1, select("#", container:GetChildren()) do
		local child = select(i, container:GetChildren())
		if child and not (child.IsForbidden and child:IsForbidden()) and child.Icon then
			apply_button_style(child, size, frame)
		end
	end

	return size, col_spacing, row_spacing
end

local function create_single_container(frame, db, is_buff)
	local ok, container = pcall(CreateFrame, "AuraContainer", nil, frame, "CustomAuraContainerTemplate")
	if not ok or not container then
		return nil
	end

	local _, col_spacing, row_spacing = configure_container_layout(container, frame, db, is_buff)
	local max_count = is_buff and (db.max_buffs or 12) or (db.max_debuffs or 12)

	local group_opts = {
		maxFrameCount = max_count,
		layout = {
			elementSpacing = col_spacing,
			lineSpacing = row_spacing,
		},
		initializeFrame = create_aura_button_init(container, is_buff, frame),
	}
	if _G.AuraContainerSortMethod and _G.AuraContainerSortMethod.ExpirationOnly then
		group_opts.sortMethod = _G.AuraContainerSortMethod.ExpirationOnly
	end
	if _G.AuraContainerSortDirection and _G.AuraContainerSortDirection.Normal then
		group_opts.sortDirection = _G.AuraContainerSortDirection.Normal
	end

	local filter = is_buff and "HELPFUL" or "HARMFUL"
	if container.AddAuraGroup then
		container:AddAuraGroup(is_buff and "Buffs" or "Debuffs", filter, group_opts)
	end

	if container.SetEnabled then
		container:SetEnabled(false)
	end
	container:Hide()
	return container
end

local function ensure_containers(frame, db)
	if frame.pb4_secure_auras then
		return frame.pb4_secure_auras
	end
	if frame.force_show then
		return nil
	end

	local pair = {
		buff = create_single_container(frame, db, true),
		debuff = create_single_container(frame, db, false),
	}
	frame.pb4_secure_auras = pair
	return pair
end

function PitBull4_Aura:UpdateSecureContainers(frame, db, use_buff_container, use_debuff_container)
	if not frame then return end
	local pair = frame.pb4_secure_auras
	if (use_buff_container or use_debuff_container) and not pair then
		pair = ensure_containers(frame, db)
	end
	if not pair then return end

	local unit = frame.unit
	local function update_one(container, is_buff, active)
		if not container then return end
		if active and unit then
			configure_container_layout(container, frame, db, is_buff)
			if container.GetUnit and container:GetUnit() ~= unit then
				container:SetUnit(unit)
			elseif not container.GetUnit and container.SetUnit then
				container:SetUnit(unit)
			end
			if container.SetEnabled then
				container:SetEnabled(true)
			end
			container:Show()
			if container.ApplyLayout then
				container:ApplyLayout()
			end
			if container.UpdateAllAuras then
				container:UpdateAllAuras()
			end
		else
			if container.SetEnabled then
				container:SetEnabled(false)
			end
			container:Hide()
		end
	end

	update_one(pair.buff, true, use_buff_container and db.enabled and db.enabled_buffs)
	update_one(pair.debuff, false, use_debuff_container and db.enabled and db.enabled_debuffs)
end

function PitBull4_Aura:ClearSecureContainers(frame)
	local pair = frame and frame.pb4_secure_auras
	if not pair then return end
	if pair.buff then
		if pair.buff.SetEnabled then pair.buff:SetEnabled(false) end
		pair.buff:Hide()
	end
	if pair.debuff then
		if pair.debuff.SetEnabled then pair.debuff:SetEnabled(false) end
		pair.debuff:Hide()
	end
end
