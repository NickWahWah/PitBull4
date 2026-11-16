-- Default UI profile preset for fresh installs (WoW Forever 16001)
-- Includes both 'Default' and a backup 'Hunter' profile.
if PitBull4DB == nil then
PitBull4DB = {
["namespaces"] = {
["Highlight"] = {
["profiles"] = {
["Default"] = {
},
["Hunter"] = {
},
},
},
["ResurrectionIcon"] = {
["profiles"] = {
["Default"] = {
["layouts"] = {
["无BUFF血条"] = {
["position"] = 1.00001,
["location"] = "edge_top",
["size"] = 1,
},
},
},
["Hunter"] = {
["layouts"] = {
["无BUFF血条"] = {
["location"] = "edge_top",
["position"] = 1.00001,
["size"] = 1,
},
},
},
},
},
["RangeFader"] = {
["profiles"] = {
["Default"] = {
["layouts"] = {
["玩家自己血条"] = {
["enabled"] = true,
["out_of_range_opacity"] = 0.4,
},
["无BUFF血条"] = {
["enabled"] = true,
["out_of_range_opacity"] = 0.4,
},
["精简血条"] = {
["enabled"] = true,
["out_of_range_opacity"] = 0.4,
},
["目标血条"] = {
["enabled"] = true,
["out_of_range_opacity"] = 0.4,
},
["宠物血条"] = {
["enabled"] = true,
["out_of_range_opacity"] = 0.4,
},
},
},
["Hunter"] = {
["layouts"] = {
["玩家自己血条"] = {
["enabled"] = true,
["out_of_range_opacity"] = 0.4,
},
["无BUFF血条"] = {
["enabled"] = true,
["out_of_range_opacity"] = 0.4,
},
["精简血条"] = {
["enabled"] = true,
["out_of_range_opacity"] = 0.4,
},
["目标血条"] = {
["enabled"] = true,
["out_of_range_opacity"] = 0.4,
},
["宠物血条"] = {
["enabled"] = true,
["out_of_range_opacity"] = 0.4,
},
},
},
},
},
["CastBarLatency"] = {
["profiles"] = {
["Default"] = {
["layouts"] = {
["无BUFF血条"] = {
["enabled"] = false,
},
["宠物血条"] = {
["enabled"] = false,
},
},
},
["Hunter"] = {
["layouts"] = {
["无BUFF血条"] = {
["enabled"] = false,
},
["宠物血条"] = {
["enabled"] = false,
},
},
},
},
},
["PhaseIcon"] = {
["profiles"] = {
["Default"] = {
["layouts"] = {
["玩家自己血条"] = {
["position"] = 1.00001,
},
["宠物血条"] = {
["position"] = 1.00002,
},
},
},
["Hunter"] = {
["layouts"] = {
["宠物血条"] = {
["position"] = 1.00002,
},
},
},
},
},
["ComboPoints"] = {
["profiles"] = {
["Default"] = {
["layouts"] = {
["队伍的目标"] = {
["enabled"] = false,
},
["宠物血条"] = {
["enabled"] = false,
["position"] = 1.00001,
},
["玩家自己血条"] = {
["enabled"] = false,
["position"] = 1.00001,
},
["无BUFF血条"] = {
["enabled"] = false,
},
["精简血条"] = {
["enabled"] = false,
},
["目标血条"] = {
["enabled"] = false,
},
["标准"] = {
["position"] = 1.00001,
},
},
},
["Hunter"] = {
["layouts"] = {
["队伍的目标"] = {
["enabled"] = false,
},
["玩家自己血条"] = {
["enabled"] = false,
},
["无BUFF血条"] = {
["enabled"] = false,
},
["精简血条"] = {
["enabled"] = false,
},
["目标血条"] = {
["enabled"] = false,
},
["宠物血条"] = {
["enabled"] = false,
["position"] = 1.00001,
},
},
},
},
},
["RoleIcon"] = {
["profiles"] = {
["Default"] = {
["layouts"] = {
["玩家自己血条"] = {
["position"] = 1.00002,
},
["宠物血条"] = {
["position"] = 1.00001,
},
},
},
["Hunter"] = {
["layouts"] = {
["宠物血条"] = {
["position"] = 1.00001,
},
},
},
},
},
["LuaTexts"] = {
["profiles"] = {
["Default"] = {
["layouts"] = {
["队伍的目标"] = {
["first"] = false,
["elements"] = {
["Lua:能量"] = {
["enabled"] = false,
["exists"] = true,
["code"] = "local max = MaxPower(unit)\nif not issecretvalue(max) then\n  if max > 0 then\n    return \"%s/%s\",Power(unit),max\n  end\nelse\n  return \"%s/%s\",Power(unit),max\nend",
["location"] = "right",
["events"] = {
["UNIT_MAXPOWER"] = true,
["UNIT_POWER_FREQUENT"] = true,
},
["attach_to"] = "PowerBar",
["size"] = 0.55,
},
["Lua:名称"] = {
["exists"] = true,
["code"] = "return '%s %s',Name(unit, true),Angle(AFK(unit) or DND(unit))",
["location"] = "center",
["events"] = {
["PLAYER_FLAGS_CHANGED"] = true,
["UNIT_NAME_UPDATE"] = true,
},
["attach_to"] = "HealthBar",
["size"] = 0.8,
},
["Lua:施法"] = {
["events"] = {
["UNIT_SPELLCAST_START"] = true,
["UNIT_SPELLCAST_INTERRUPTED"] = true,
["UNIT_SPELLCAST_CHANNEL_START"] = true,
["UNIT_SPELLCAST_DELAYED"] = true,
["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
["UNIT_SPELLCAST_STOP"] = true,
["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
["UNIT_SPELLCAST_FAILED"] = true,
},
["exists"] = true,
["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  local spell,stop_message,target = cast_data.spell,cast_data.stop_message,cast_data.target\n  local stop_time,stop_duration = cast_data.stop_time\n  if stop_time then\n    stop_duration = GetTime() - stop_time\n  end\n  Alpha(-(stop_duration or 0) + 1)\n  if stop_message then\n    return stop_message\n  elseif target then\n    return \"%s (%s)\",spell,target\n  else\n    return spell\n  end\nend\nreturn ConfigMode()",
["location"] = "left",
["attach_to"] = "CastBar",
},
["Lua:声望"] = {
["events"] = {
["UNIT_FACTION"] = true,
["UPDATE_FACTION"] = true,
},
["exists"] = true,
["code"] = "local name, _, _, max, cur = WatchedFactionInfo()\nif not name then return ConfigMode() end\nif IsMouseOver() then\n  return name\nelse\n  return \"%d/%d (%s%%)\",cur,max,Percent(cur,max)\nend",
["location"] = "center",
["attach_to"] = "ReputationBar",
},
["Lua:PvP 计时器"] = {
["enabled"] = false,
["events"] = {
["PLAYER_FLAGS_CHANGED"] = true,
},
["exists"] = true,
["code"] = "if unit == \"player\" then\n  local pvp = PVPDuration()\n  if pvp then\n    return \"|cffff0000%s|r\",FormatDuration(pvp)\n  end\nend",
["location"] = "out_right_top",
},
["Lua:德鲁伊法力值"] = {
["events"] = {
["UNIT_DISPLAYPOWER"] = true,
["UNIT_MAXPOWER"] = true,
["UNIT_POWER_FREQUENT"] = true,
},
["exists"] = true,
["code"] = "if UnitPowerType(unit) ~= 0 then\n  return \"%s/%s\",Power(unit,0),MaxPower(unit,0)\nend",
["location"] = "center",
["attach_to"] = "AltManaBar",
},
["Lua:生命值"] = {
["enabled"] = false,
["events"] = {
["UNIT_MAXHEALTH"] = true,
["UNIT_HEALTH"] = true,
["UNIT_AURA"] = true,
},
["exists"] = true,
["code"] = "local s = Status(unit)\nif s then\n  return s\nend\nreturn \"%s/%s\",HP(unit),MaxHP(unit)",
["location"] = "right",
["attach_to"] = "HealthBar",
},
["Lua:职业"] = {
["enabled"] = false,
["exists"] = true,
["code"] = "local dr,dg,db = DifficultyColor(unit)\nlocal form = DruidForm(unit)\nlocal classification = Classification(unit)\nif UnitIsPlayer(unit) or (not UnitIsFriend(unit,\"player\") and not IsPet(unit)) then\n  local cr,cg,cb = ClassColor(unit)\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),SmartRace(unit) or ''\n  end\nelse\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),SmartRace(unit) or ''\n  end\nend",
["location"] = "left",
["events"] = {
["UNIT_LEVEL"] = true,
["UNIT_CLASSIFICATION_CHANGED"] = true,
["UNIT_AURA"] = true,
},
["attach_to"] = "PowerBar",
["size"] = 0.75,
},
["Lua:经验值"] = {
["events"] = {
["PLAYER_XP_UPDATE"] = true,
["UNIT_PET_EXPERIENCE"] = true,
},
["exists"] = true,
["code"] = "local cur, max, rest = XP(unit), MaxXP(unit), RestXP(unit)\nif rest then\n  return \"%s/%s (%s%%) R: %s%%\",cur,max,Percent(cur,max),Percent(rest,max)\nelse\n  return \"%s/%s (%s%%)\",cur,max,Percent(cur,max)\nend",
["location"] = "center",
["attach_to"] = "ExperienceBar",
},
["Lua:施法时间"] = {
["events"] = {
["UNIT_SPELLCAST_SUCCEEDED"] = true,
["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
["UNIT_SPELLCAST_INTERRUPTED"] = true,
["UNIT_SPELLCAST_CHANNEL_START"] = true,
["UNIT_SPELLCAST_DELAYED"] = true,
["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
["UNIT_SPELLCAST_STOP"] = true,
["UNIT_SPELLCAST_START"] = true,
["UNIT_SPELLCAST_FAILED"] = true,
},
["exists"] = true,
["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  if not cast_data.stop_time then\n    local delay,end_time = cast_data.delay, cast_data.end_time\n    local duration\n    if end_time then\n      duration = end_time - GetTime()\n    end\n    if delay and delay ~= 0 then\n      local delay_sign = '+'\n      if delay < 0 then\n        delay_sign = ''\n      end\n      if duration and duration >= 0 then\n        return \"|cffff0000%s%s|r %.1f\",delay_sign,Round(delay,1),duration\n      else\n        return \"|cffff0000%s%s|r\",delay_sign,Round(delay,1)\n      end\n    elseif duration and duration >= 0 then\n      return \"%.1f\",duration\n    end\n  end\nend\nreturn ConfigMode()",
["location"] = "right",
["attach_to"] = "CastBar",
},
["Lua:威胁值"] = {
["events"] = {
["UNIT_THREAT_LIST_UPDATE"] = true,
["UNIT_THREAT_SITUATION_UPDATE"] = true,
},
["exists"] = true,
["code"] = "local unit_a,unit_b = ThreatPair(unit)\nif unit_a and unit_b then\n  local _,_,percent = UnitDetailedThreatSituation(unit_a, unit_b)\n  if percent and percent ~= 0 then\n    return \"%s%%\",Round(percent,1)\n  end\nend\nreturn ConfigMode()",
["location"] = "center",
["attach_to"] = "ThreatBar",
},
},
},
["宠物血条"] = {
["first"] = false,
["elements"] = {
["Lua:能量"] = {
["exists"] = true,
["code"] = "local max = MaxPower(unit)\nif not issecretvalue(max) then\n  if max > 0 then\n    return \"%s/%s\",Power(unit),max\n  end\nelse\n  return \"%s/%s\",Power(unit),max\nend",
["location"] = "right",
["events"] = {
["UNIT_MAXPOWER"] = true,
["UNIT_POWER_FREQUENT"] = true,
},
["attach_to"] = "PowerBar",
["size"] = 0.75,
},
["Lua:威胁值"] = {
["exists"] = true,
["events"] = {
["UNIT_THREAT_LIST_UPDATE"] = true,
["UNIT_THREAT_SITUATION_UPDATE"] = true,
},
["code"] = "local unit_a,unit_b = ThreatPair(unit)\nif unit_a and unit_b then\n  local _,_,percent = UnitDetailedThreatSituation(unit_a, unit_b)\n  if percent and percent ~= 0 then\n    return \"%s%%\",Round(percent,1)\n  end\nend\nreturn ConfigMode()",
["location"] = "center",
["attach_to"] = "ThreatBar",
},
["Lua:施法"] = {
["exists"] = true,
["events"] = {
["UNIT_SPELLCAST_INTERRUPTED"] = true,
["UNIT_SPELLCAST_START"] = true,
["UNIT_SPELLCAST_CHANNEL_START"] = true,
["UNIT_SPELLCAST_DELAYED"] = true,
["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
["UNIT_SPELLCAST_STOP"] = true,
["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
["UNIT_SPELLCAST_FAILED"] = true,
},
["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  local spell,stop_message,target = cast_data.spell,cast_data.stop_message,cast_data.target\n  local stop_time,stop_duration = cast_data.stop_time\n  if stop_time then\n    stop_duration = GetTime() - stop_time\n  end\n  Alpha(-(stop_duration or 0) + 1)\n  if stop_message then\n    return stop_message\n  elseif target then\n    return \"%s (%s)\",spell,target\n  else\n    return spell\n  end\nend\nreturn ConfigMode()",
["location"] = "left",
["attach_to"] = "CastBar",
},
["Lua:声望"] = {
["exists"] = true,
["events"] = {
["UNIT_FACTION"] = true,
["UPDATE_FACTION"] = true,
},
["code"] = "local name, _, _, max, cur = WatchedFactionInfo()\nif not name then return ConfigMode() end\nif IsMouseOver() then\n  return name\nelse\n  return \"%d/%d (%s%%)\",cur,max,Percent(cur,max)\nend",
["location"] = "center",
["attach_to"] = "ReputationBar",
},
["Lua:PvP 计时器"] = {
["enabled"] = false,
["exists"] = true,
["events"] = {
["PLAYER_FLAGS_CHANGED"] = true,
},
["code"] = "if unit == \"player\" then\n  local pvp = PVPDuration()\n  if pvp then\n    return \"|cffff0000%s|r\",FormatDuration(pvp)\n  end\nend",
["location"] = "out_right_top",
},
["Lua:德鲁伊法力值"] = {
["exists"] = true,
["events"] = {
["UNIT_DISPLAYPOWER"] = true,
["UNIT_MAXPOWER"] = true,
["UNIT_POWER_FREQUENT"] = true,
},
["code"] = "if UnitPowerType(unit) ~= 0 then\n  return \"%s/%s\",Power(unit,0),MaxPower(unit,0)\nend",
["location"] = "center",
["attach_to"] = "AltManaBar",
},
["Lua:生命值"] = {
["exists"] = true,
["events"] = {
["UNIT_MAXHEALTH"] = true,
["UNIT_HEALTH"] = true,
["UNIT_AURA"] = true,
},
["code"] = "local s = Status(unit)\nif s then\n  return s\nend\nreturn \"%s/%s\",HP(unit),MaxHP(unit)",
["location"] = "right",
["attach_to"] = "HealthBar",
},
["Lua:职业"] = {
["enabled"] = false,
["exists"] = true,
["events"] = {
["UNIT_LEVEL"] = true,
["UNIT_CLASSIFICATION_CHANGED"] = true,
["UNIT_AURA"] = true,
},
["code"] = "local dr,dg,db = DifficultyColor(unit)\nlocal form = DruidForm(unit)\nlocal classification = Classification(unit)\nif UnitIsPlayer(unit) or (not UnitIsFriend(unit,\"player\") and not IsPet(unit)) then\n  local cr,cg,cb = ClassColor(unit)\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),SmartRace(unit) or ''\n  end\nelse\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),SmartRace(unit) or ''\n  end\nend",
["location"] = "left",
["attach_to"] = "PowerBar",
},
["Lua:经验值"] = {
["exists"] = true,
["events"] = {
["PLAYER_XP_UPDATE"] = true,
["UNIT_PET_EXPERIENCE"] = true,
},
["code"] = "local cur, max, rest = XP(unit), MaxXP(unit), RestXP(unit)\nif rest then\n  return \"%s/%s (%s%%) R: %s%%\",cur,max,Percent(cur,max),Percent(rest,max)\nelse\n  return \"%s/%s (%s%%)\",cur,max,Percent(cur,max)\nend",
["location"] = "center",
["attach_to"] = "ExperienceBar",
},
["Lua:施法时间"] = {
["exists"] = true,
["events"] = {
["UNIT_SPELLCAST_SUCCEEDED"] = true,
["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
["UNIT_SPELLCAST_INTERRUPTED"] = true,
["UNIT_SPELLCAST_CHANNEL_START"] = true,
["UNIT_SPELLCAST_DELAYED"] = true,
["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
["UNIT_SPELLCAST_STOP"] = true,
["UNIT_SPELLCAST_START"] = true,
["UNIT_SPELLCAST_FAILED"] = true,
},
["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  if not cast_data.stop_time then\n    local delay,end_time = cast_data.delay, cast_data.end_time\n    local duration\n    if end_time then\n      duration = end_time - GetTime()\n    end\n    if delay and delay ~= 0 then\n      local delay_sign = '+'\n      if delay < 0 then\n        delay_sign = ''\n      end\n      if duration and duration >= 0 then\n        return \"|cffff0000%s%s|r %.1f\",delay_sign,Round(delay,1),duration\n      else\n        return \"|cffff0000%s%s|r\",delay_sign,Round(delay,1)\n      end\n    elseif duration and duration >= 0 then\n      return \"%.1f\",duration\n    end\n  end\nend\nreturn ConfigMode()",
["location"] = "right",
["attach_to"] = "CastBar",
},
["Lua:名称"] = {
["enabled"] = false,
["exists"] = true,
["events"] = {
["PLAYER_FLAGS_CHANGED"] = true,
["UNIT_NAME_UPDATE"] = true,
},
["code"] = "return '%s %s',Name(unit),Angle(AFK(unit) or DND(unit))",
["location"] = "out_right",
["attach_to"] = "HealthBar",
},
},
},
["玩家自己血条"] = {
["first"] = false,
["elements"] = {
["Lua:能量"] = {
["exists"] = true,
["events"] = {
["UNIT_MAXPOWER"] = true,
["UNIT_POWER_FREQUENT"] = true,
},
["code"] = "local max = MaxPower(unit)\nif not issecretvalue(max) then\n  if max > 0 then\n    return \"%s/%s\",Power(unit),max\n  end\nelse\n  return \"%s/%s\",Power(unit),max\nend",
["location"] = "right",
["attach_to"] = "PowerBar",
},
["Lua:威胁值"] = {
["exists"] = true,
["events"] = {
["UNIT_THREAT_LIST_UPDATE"] = true,
["UNIT_THREAT_SITUATION_UPDATE"] = true,
},
["code"] = "local unit_a,unit_b = ThreatPair(unit)\nif unit_a and unit_b then\n  local _,_,percent = UnitDetailedThreatSituation(unit_a, unit_b)\n  if percent and percent ~= 0 then\n    return \"%s%%\",Round(percent,1)\n  end\nend\nreturn ConfigMode()",
["location"] = "center",
["attach_to"] = "ThreatBar",
},
["Lua:施法"] = {
["exists"] = true,
["events"] = {
["UNIT_SPELLCAST_INTERRUPTED"] = true,
["UNIT_SPELLCAST_START"] = true,
["UNIT_SPELLCAST_CHANNEL_START"] = true,
["UNIT_SPELLCAST_DELAYED"] = true,
["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
["UNIT_SPELLCAST_STOP"] = true,
["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
["UNIT_SPELLCAST_FAILED"] = true,
},
["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  local spell,stop_message,target = cast_data.spell,cast_data.stop_message,cast_data.target\n  local stop_time,stop_duration = cast_data.stop_time\n  if stop_time then\n    stop_duration = GetTime() - stop_time\n  end\n  Alpha(-(stop_duration or 0) + 1)\n  if stop_message then\n    return stop_message\n  elseif target then\n    return \"%s (%s)\",spell,target\n  else\n    return spell\n  end\nend\nreturn ConfigMode()",
["location"] = "left",
["attach_to"] = "CastBar",
},
["Lua:声望"] = {
["exists"] = true,
["events"] = {
["UNIT_FACTION"] = true,
["UPDATE_FACTION"] = true,
},
["code"] = "local name, _, _, max, cur = WatchedFactionInfo()\nif not name then return ConfigMode() end\nif IsMouseOver() then\n  return name\nelse\n  return \"%d/%d (%s%%)\",cur,max,Percent(cur,max)\nend",
["location"] = "center",
["attach_to"] = "ReputationBar",
},
["Lua:PvP 计时器"] = {
["enabled"] = false,
["exists"] = true,
["events"] = {
["PLAYER_FLAGS_CHANGED"] = true,
},
["code"] = "if unit == \"player\" then\n  local pvp = PVPDuration()\n  if pvp then\n    return \"|cffff0000%s|r\",FormatDuration(pvp)\n  end\nend",
["location"] = "out_right_top",
},
["Lua:德鲁伊法力值"] = {
["exists"] = true,
["events"] = {
["UNIT_DISPLAYPOWER"] = true,
["UNIT_MAXPOWER"] = true,
["UNIT_POWER_FREQUENT"] = true,
},
["code"] = "if UnitPowerType(unit) ~= 0 then\n  return \"%s/%s\",Power(unit,0),MaxPower(unit,0)\nend",
["location"] = "center",
["attach_to"] = "AltManaBar",
},
["Lua:生命值"] = {
["exists"] = true,
["code"] = "local s = Status(unit)\nif s then\n  return s\nend\nreturn \"%s/%s\",HP(unit),MaxHP(unit)",
["location"] = "right",
["events"] = {
["UNIT_MAXHEALTH"] = true,
["UNIT_HEALTH"] = true,
["UNIT_AURA"] = true,
},
["attach_to"] = "HealthBar",
["size"] = 1.65,
},
["Lua:职业"] = {
["exists"] = true,
["code"] = "local dr,dg,db = DifficultyColor(unit)\nlocal form = DruidForm(unit)\nlocal classification = Classification(unit)\nif UnitIsPlayer(unit) or (not UnitIsFriend(unit,\"player\") and not IsPet(unit)) then\n  local cr,cg,cb = ClassColor(unit)\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),SmartRace(unit) or ''\n  end\nelse\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),SmartRace(unit) or ''\n  end\nend",
["location"] = "left",
["events"] = {
["UNIT_LEVEL"] = true,
["UNIT_CLASSIFICATION_CHANGED"] = true,
["UNIT_AURA"] = true,
},
["attach_to"] = "PowerBar",
["size"] = 0.7,
},
["Lua:经验值"] = {
["exists"] = true,
["events"] = {
["PLAYER_XP_UPDATE"] = true,
["UNIT_PET_EXPERIENCE"] = true,
},
["code"] = "local cur, max, rest = XP(unit), MaxXP(unit), RestXP(unit)\nif rest then\n  return \"%s/%s (%s%%) R: %s%%\",cur,max,Percent(cur,max),Percent(rest,max)\nelse\n  return \"%s/%s (%s%%)\",cur,max,Percent(cur,max)\nend",
["location"] = "center",
["attach_to"] = "ExperienceBar",
},
["Lua:施法时间"] = {
["exists"] = true,
["events"] = {
["UNIT_SPELLCAST_SUCCEEDED"] = true,
["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
["UNIT_SPELLCAST_INTERRUPTED"] = true,
["UNIT_SPELLCAST_CHANNEL_START"] = true,
["UNIT_SPELLCAST_DELAYED"] = true,
["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
["UNIT_SPELLCAST_STOP"] = true,
["UNIT_SPELLCAST_START"] = true,
["UNIT_SPELLCAST_FAILED"] = true,
},
["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  if not cast_data.stop_time then\n    local delay,end_time = cast_data.delay, cast_data.end_time\n    local duration\n    if end_time then\n      duration = end_time - GetTime()\n    end\n    if delay and delay ~= 0 then\n      local delay_sign = '+'\n      if delay < 0 then\n        delay_sign = ''\n      end\n      if duration and duration >= 0 then\n        return \"|cffff0000%s%s|r %.1f\",delay_sign,Round(delay,1),duration\n      else\n        return \"|cffff0000%s%s|r\",delay_sign,Round(delay,1)\n      end\n    elseif duration and duration >= 0 then\n      return \"%.1f\",duration\n    end\n  end\nend\nreturn ConfigMode()",
["location"] = "right",
["attach_to"] = "CastBar",
},
["Lua:名称"] = {
["exists"] = true,
["events"] = {
["PLAYER_FLAGS_CHANGED"] = true,
["UNIT_NAME_UPDATE"] = true,
},
["code"] = "return '%s %s',Name(unit, true),Angle(AFK(unit) or DND(unit))",
["location"] = "out_top",
},
},
},
["无BUFF血条"] = {
["first"] = false,
["elements"] = {
["Lua:生命值"] = {
["enabled"] = false,
["exists"] = true,
["events"] = {
["UNIT_MAXHEALTH"] = true,
["UNIT_HEALTH"] = true,
["UNIT_AURA"] = true,
},
["code"] = "local s = Status(unit)\nif s then\n  return s\nend\nreturn \"%s/%s\",HP(unit),MaxHP(unit)",
["location"] = "right",
["attach_to"] = "HealthBar",
},
["Lua:威胁值"] = {
["enabled"] = false,
["exists"] = true,
["events"] = {
["UNIT_THREAT_LIST_UPDATE"] = true,
["UNIT_THREAT_SITUATION_UPDATE"] = true,
},
["code"] = "local unit_a,unit_b = ThreatPair(unit)\nif unit_a and unit_b then\n  local _,_,percent = UnitDetailedThreatSituation(unit_a, unit_b)\n  if percent and percent ~= 0 then\n    return \"%s%%\",Round(percent,1)\n  end\nend\nreturn ConfigMode()",
["location"] = "center",
["attach_to"] = "ThreatBar",
},
["Lua:施法"] = {
["enabled"] = false,
["exists"] = true,
["events"] = {
["UNIT_SPELLCAST_START"] = true,
["UNIT_SPELLCAST_INTERRUPTED"] = true,
["UNIT_SPELLCAST_CHANNEL_START"] = true,
["UNIT_SPELLCAST_DELAYED"] = true,
["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
["UNIT_SPELLCAST_STOP"] = true,
["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
["UNIT_SPELLCAST_FAILED"] = true,
},
["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  local spell,stop_message,target = cast_data.spell,cast_data.stop_message,cast_data.target\n  local stop_time,stop_duration = cast_data.stop_time\n  if stop_time then\n    stop_duration = GetTime() - stop_time\n  end\n  Alpha(-(stop_duration or 0) + 1)\n  if stop_message then\n    return stop_message\n  elseif target then\n    return \"%s (%s)\",spell,target\n  else\n    return spell\n  end\nend\nreturn ConfigMode()",
["location"] = "left",
["attach_to"] = "CastBar",
},
["Lua:声望"] = {
["enabled"] = false,
["exists"] = true,
["events"] = {
["UNIT_FACTION"] = true,
["UPDATE_FACTION"] = true,
},
["code"] = "local name, _, _, max, cur = WatchedFactionInfo()\nif not name then return ConfigMode() end\nif IsMouseOver() then\n  return name\nelse\n  return \"%d/%d (%s%%)\",cur,max,Percent(cur,max)\nend",
["location"] = "center",
["attach_to"] = "ReputationBar",
},
["Lua:PvP 计时器"] = {
["enabled"] = false,
["exists"] = true,
["events"] = {
["PLAYER_FLAGS_CHANGED"] = true,
},
["code"] = "if unit == \"player\" then\n  local pvp = PVPDuration()\n  if pvp then\n    return \"|cffff0000%s|r\",FormatDuration(pvp)\n  end\nend",
["location"] = "out_right_top",
},
["Lua:名称"] = {
["code"] = "return '%s %s',Name(unit, true),Angle(AFK(unit) or DND(unit))",
["exists"] = true,
["position"] = 1.00001,
["location"] = "right",
["events"] = {
["PLAYER_FLAGS_CHANGED"] = true,
["UNIT_NAME_UPDATE"] = true,
},
["attach_to"] = "HealthBar",
["size"] = 0.9,
},
["Lua:能量"] = {
["enabled"] = false,
["exists"] = true,
["code"] = "local max = MaxPower(unit)\nif not issecretvalue(max) then\n  if max > 0 then\n    return \"%s/%s\",Power(unit),max\n  end\nelse\n  return \"%s/%s\",Power(unit),max\nend",
["location"] = "right",
["events"] = {
["UNIT_MAXPOWER"] = true,
["UNIT_POWER_FREQUENT"] = true,
},
["attach_to"] = "PowerBar",
["size"] = 0.75,
},
["Lua:职业"] = {
["enabled"] = false,
["exists"] = true,
["events"] = {
["UNIT_LEVEL"] = true,
["UNIT_CLASSIFICATION_CHANGED"] = true,
["UNIT_AURA"] = true,
},
["code"] = "local dr,dg,db = DifficultyColor(unit)\nlocal form = DruidForm(unit)\nlocal classification = Classification(unit)\nif UnitIsPlayer(unit) or (not UnitIsFriend(unit,\"player\") and not IsPet(unit)) then\n  local cr,cg,cb = ClassColor(unit)\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),SmartRace(unit) or ''\n  end\nelse\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),SmartRace(unit) or ''\n  end\nend",
["location"] = "left",
["attach_to"] = "PowerBar",
},
["Lua:经验值"] = {
["enabled"] = false,
["exists"] = true,
["events"] = {
["PLAYER_XP_UPDATE"] = true,
["UNIT_PET_EXPERIENCE"] = true,
},
["code"] = "local cur, max, rest = XP(unit), MaxXP(unit), RestXP(unit)\nif rest then\n  return \"%s/%s (%s%%) R: %s%%\",cur,max,Percent(cur,max),Percent(rest,max)\nelse\n  return \"%s/%s (%s%%)\",cur,max,Percent(cur,max)\nend",
["location"] = "center",
["attach_to"] = "ExperienceBar",
},
["Lua:施法时间"] = {
["enabled"] = false,
["exists"] = true,
["events"] = {
["UNIT_SPELLCAST_SUCCEEDED"] = true,
["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
["UNIT_SPELLCAST_INTERRUPTED"] = true,
["UNIT_SPELLCAST_CHANNEL_START"] = true,
["UNIT_SPELLCAST_DELAYED"] = true,
["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
["UNIT_SPELLCAST_STOP"] = true,
["UNIT_SPELLCAST_START"] = true,
["UNIT_SPELLCAST_FAILED"] = true,
},
["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  if not cast_data.stop_time then\n    local delay,end_time = cast_data.delay, cast_data.end_time\n    local duration\n    if end_time then\n      duration = end_time - GetTime()\n    end\n    if delay and delay ~= 0 then\n      local delay_sign = '+'\n      if delay < 0 then\n        delay_sign = ''\n      end\n      if duration and duration >= 0 then\n        return \"|cffff0000%s%s|r %.1f\",delay_sign,Round(delay,1),duration\n      else\n        return \"|cffff0000%s%s|r\",delay_sign,Round(delay,1)\n      end\n    elseif duration and duration >= 0 then\n      return \"%.1f\",duration\n    end\n  end\nend\nreturn ConfigMode()",
["location"] = "right",
["attach_to"] = "CastBar",
},
["Lua:德鲁伊法力值"] = {
["enabled"] = false,
["exists"] = true,
["events"] = {
["UNIT_DISPLAYPOWER"] = true,
["UNIT_MAXPOWER"] = true,
["UNIT_POWER_FREQUENT"] = true,
},
["code"] = "if UnitPowerType(unit) ~= 0 then\n  return \"%s/%s\",Power(unit,0),MaxPower(unit,0)\nend",
["location"] = "center",
["attach_to"] = "AltManaBar",
},
},
},
["精简血条"] = {
["first"] = false,
["elements"] = {
["Lua:生命值"] = {
["exists"] = true,
["events"] = {
["UNIT_MAXHEALTH"] = true,
["UNIT_HEALTH"] = true,
["UNIT_AURA"] = true,
},
["code"] = "local s = Status(unit)\nif s then\n  return s\nend\nreturn \"%s/%s\",HP(unit),MaxHP(unit)",
["location"] = "right",
["attach_to"] = "HealthBar",
},
["Lua:名称"] = {
["exists"] = true,
["events"] = {
["PLAYER_FLAGS_CHANGED"] = true,
["UNIT_NAME_UPDATE"] = true,
},
["code"] = "return '%s %s',Name(unit, true),Angle(AFK(unit) or DND(unit))",
["location"] = "out_top_right",
},
["Lua:施法"] = {
["exists"] = true,
["events"] = {
["UNIT_SPELLCAST_START"] = true,
["UNIT_SPELLCAST_INTERRUPTED"] = true,
["UNIT_SPELLCAST_CHANNEL_START"] = true,
["UNIT_SPELLCAST_DELAYED"] = true,
["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
["UNIT_SPELLCAST_STOP"] = true,
["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
["UNIT_SPELLCAST_FAILED"] = true,
},
["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  local spell,stop_message,target = cast_data.spell,cast_data.stop_message,cast_data.target\n  local stop_time,stop_duration = cast_data.stop_time\n  if stop_time then\n    stop_duration = GetTime() - stop_time\n  end\n  Alpha(-(stop_duration or 0) + 1)\n  if stop_message then\n    return stop_message\n  elseif target then\n    return \"%s (%s)\",spell,target\n  else\n    return spell\n  end\nend\nreturn ConfigMode()",
["location"] = "left",
["attach_to"] = "CastBar",
},
["Lua:声望"] = {
["exists"] = true,
["events"] = {
["UNIT_FACTION"] = true,
["UPDATE_FACTION"] = true,
},
["code"] = "local name, _, _, max, cur = WatchedFactionInfo()\nif not name then return ConfigMode() end\nif IsMouseOver() then\n  return name\nelse\n  return \"%d/%d (%s%%)\",cur,max,Percent(cur,max)\nend",
["location"] = "center",
["attach_to"] = "ReputationBar",
},
["Lua:PvP 计时器"] = {
["enabled"] = false,
["exists"] = true,
["events"] = {
["PLAYER_FLAGS_CHANGED"] = true,
},
["code"] = "if unit == \"player\" then\n  local pvp = PVPDuration()\n  if pvp then\n    return \"|cffff0000%s|r\",FormatDuration(pvp)\n  end\nend",
["location"] = "out_right_top",
},
["Lua:威胁值"] = {
["exists"] = true,
["events"] = {
["UNIT_THREAT_LIST_UPDATE"] = true,
["UNIT_THREAT_SITUATION_UPDATE"] = true,
},
["code"] = "local unit_a,unit_b = ThreatPair(unit)\nif unit_a and unit_b then\n  local _,_,percent = UnitDetailedThreatSituation(unit_a, unit_b)\n  if percent and percent ~= 0 then\n    return \"%s%%\",Round(percent,1)\n  end\nend\nreturn ConfigMode()",
["location"] = "center",
["attach_to"] = "ThreatBar",
},
["Lua:能量"] = {
["exists"] = true,
["code"] = "local max = MaxPower(unit)\nif not issecretvalue(max) then\n  if max > 0 then\n    return \"%s/%s\",Power(unit),max\n  end\nelse\n  return \"%s/%s\",Power(unit),max\nend",
["location"] = "right",
["events"] = {
["UNIT_MAXPOWER"] = true,
["UNIT_POWER_FREQUENT"] = true,
},
["attach_to"] = "PowerBar",
["size"] = 0.55,
},
["Lua:职业"] = {
["exists"] = true,
["code"] = "local dr,dg,db = DifficultyColor(unit)\nlocal form = DruidForm(unit)\nlocal classification = Classification(unit)\nif UnitIsPlayer(unit) or (not UnitIsFriend(unit,\"player\") and not IsPet(unit)) then\n  local cr,cg,cb = ClassColor(unit)\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),SmartRace(unit) or ''\n  end\nelse\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),SmartRace(unit) or ''\n  end\nend",
["location"] = "left",
["events"] = {
["UNIT_LEVEL"] = true,
["UNIT_CLASSIFICATION_CHANGED"] = true,
["UNIT_AURA"] = true,
},
["attach_to"] = "PowerBar",
["size"] = 0.75,
},
["Lua:经验值"] = {
["exists"] = true,
["events"] = {
["PLAYER_XP_UPDATE"] = true,
["UNIT_PET_EXPERIENCE"] = true,
},
["code"] = "local cur, max, rest = XP(unit), MaxXP(unit), RestXP(unit)\nif rest then\n  return \"%s/%s (%s%%) R: %s%%\",cur,max,Percent(cur,max),Percent(rest,max)\nelse\n  return \"%s/%s (%s%%)\",cur,max,Percent(cur,max)\nend",
["location"] = "center",
["attach_to"] = "ExperienceBar",
},
["Lua:施法时间"] = {
["exists"] = true,
["events"] = {
["UNIT_SPELLCAST_SUCCEEDED"] = true,
["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
["UNIT_SPELLCAST_INTERRUPTED"] = true,
["UNIT_SPELLCAST_CHANNEL_START"] = true,
["UNIT_SPELLCAST_DELAYED"] = true,
["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
["UNIT_SPELLCAST_STOP"] = true,
["UNIT_SPELLCAST_START"] = true,
["UNIT_SPELLCAST_FAILED"] = true,
},
["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  if not cast_data.stop_time then\n    local delay,end_time = cast_data.delay, cast_data.end_time\n    local duration\n    if end_time then\n      duration = end_time - GetTime()\n    end\n    if delay and delay ~= 0 then\n      local delay_sign = '+'\n      if delay < 0 then\n        delay_sign = ''\n      end\n      if duration and duration >= 0 then\n        return \"|cffff0000%s%s|r %.1f\",delay_sign,Round(delay,1),duration\n      else\n        return \"|cffff0000%s%s|r\",delay_sign,Round(delay,1)\n      end\n    elseif duration and duration >= 0 then\n      return \"%.1f\",duration\n    end\n  end\nend\nreturn ConfigMode()",
["location"] = "right",
["attach_to"] = "CastBar",
},
["Lua:德鲁伊法力值"] = {
["exists"] = true,
["events"] = {
["UNIT_DISPLAYPOWER"] = true,
["UNIT_MAXPOWER"] = true,
["UNIT_POWER_FREQUENT"] = true,
},
["code"] = "if UnitPowerType(unit) ~= 0 then\n  return \"%s/%s\",Power(unit,0),MaxPower(unit,0)\nend",
["location"] = "center",
["attach_to"] = "AltManaBar",
},
},
},
["普通"] = {
["first"] = false,
["elements"] = {
["Lua:能量"] = {
["exists"] = true,
["events"] = {
["UNIT_MAXPOWER"] = true,
["UNIT_POWER_FREQUENT"] = true,
},
["code"] = "local max = MaxPower(unit)\nif not issecretvalue(max) then\n  if max > 0 then\n    return \"%s/%s\",Power(unit),max\n  end\nelse\n  return \"%s/%s\",Power(unit),max\nend",
["location"] = "right",
["attach_to"] = "PowerBar",
},
["Lua:名称"] = {
["exists"] = true,
["events"] = {
["PLAYER_FLAGS_CHANGED"] = true,
["UNIT_NAME_UPDATE"] = true,
},
["code"] = "return '%s %s',Name(unit, true),Angle(AFK(unit) or DND(unit))",
["location"] = "left",
["attach_to"] = "HealthBar",
},
["Lua:施法"] = {
["exists"] = true,
["events"] = {
["UNIT_SPELLCAST_INTERRUPTED"] = true,
["UNIT_SPELLCAST_START"] = true,
["UNIT_SPELLCAST_CHANNEL_START"] = true,
["UNIT_SPELLCAST_DELAYED"] = true,
["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
["UNIT_SPELLCAST_STOP"] = true,
["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
["UNIT_SPELLCAST_FAILED"] = true,
},
["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  local spell,stop_message,target = cast_data.spell,cast_data.stop_message,cast_data.target\n  local stop_time,stop_duration = cast_data.stop_time\n  if stop_time then\n    stop_duration = GetTime() - stop_time\n  end\n  Alpha(-(stop_duration or 0) + 1)\n  if stop_message then\n    return stop_message\n  elseif target then\n    return \"%s (%s)\",spell,target\n  else\n    return spell\n  end\nend\nreturn ConfigMode()",
["location"] = "left",
["attach_to"] = "CastBar",
},
["Lua:声望"] = {
["exists"] = true,
["events"] = {
["UNIT_FACTION"] = true,
["UPDATE_FACTION"] = true,
},
["code"] = "local name, _, _, max, cur = WatchedFactionInfo()\nif not name then return ConfigMode() end\nif IsMouseOver() then\n  return name\nelse\n  return \"%d/%d (%s%%)\",cur,max,Percent(cur,max)\nend",
["location"] = "center",
["attach_to"] = "ReputationBar",
},
["Lua:PvP 计时器"] = {
["exists"] = true,
["events"] = {
["PLAYER_FLAGS_CHANGED"] = true,
},
["code"] = "if unit == \"player\" then\n  local pvp = PVPDuration()\n  if pvp then\n    return \"|cffff0000%s|r\",FormatDuration(pvp)\n  end\nend",
["location"] = "out_right_top",
},
["Lua:德鲁伊法力值"] = {
["exists"] = true,
["events"] = {
["UNIT_DISPLAYPOWER"] = true,
["UNIT_MAXPOWER"] = true,
["UNIT_POWER_FREQUENT"] = true,
},
["code"] = "if UnitPowerType(unit) ~= 0 then\n  return \"%s/%s\",Power(unit,0),MaxPower(unit,0)\nend",
["location"] = "center",
["attach_to"] = "AltManaBar",
},
["Lua:生命值"] = {
["exists"] = true,
["events"] = {
["UNIT_HEALTH"] = true,
["UNIT_MAXHEALTH"] = true,
["UNIT_AURA"] = true,
},
["code"] = "local s = Status(unit)\nif s then\n  return s\nend\nreturn \"%s/%s || %s%%\",Short(HP(unit)),Short(MaxHP(unit)),PercentHP(unit)",
["location"] = "right",
["attach_to"] = "HealthBar",
},
["Lua:职业"] = {
["exists"] = true,
["code"] = "local dr,dg,db = DifficultyColor(unit)\nlocal form = DruidForm(unit)\nlocal classification = Classification(unit)\nif UnitIsPlayer(unit) or (not UnitIsFriend(unit,\"player\") and not IsPet(unit)) then\n  local cr,cg,cb = ClassColor(unit)\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),SmartRace(unit) or ''\n  end\nelse\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),SmartRace(unit) or ''\n  end\nend",
["location"] = "left",
["events"] = {
["UNIT_LEVEL"] = true,
["UNIT_CLASSIFICATION_CHANGED"] = true,
["UNIT_AURA"] = true,
},
["attach_to"] = "PowerBar",
["size"] = 0.8500000000000001,
},
["Lua:经验值"] = {
["exists"] = true,
["events"] = {
["PLAYER_XP_UPDATE"] = true,
["UNIT_PET_EXPERIENCE"] = true,
},
["code"] = "local cur, max, rest = XP(unit), MaxXP(unit), RestXP(unit)\nif rest then\n  return \"%s/%s (%s%%) R: %s%%\",cur,max,Percent(cur,max),Percent(rest,max)\nelse\n  return \"%s/%s (%s%%)\",cur,max,Percent(cur,max)\nend",
["location"] = "center",
["attach_to"] = "ExperienceBar",
},
["Lua:施法时间"] = {
["exists"] = true,
["events"] = {
["UNIT_SPELLCAST_SUCCEEDED"] = true,
["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
["UNIT_SPELLCAST_INTERRUPTED"] = true,
["UNIT_SPELLCAST_CHANNEL_START"] = true,
["UNIT_SPELLCAST_DELAYED"] = true,
["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
["UNIT_SPELLCAST_STOP"] = true,
["UNIT_SPELLCAST_START"] = true,
["UNIT_SPELLCAST_FAILED"] = true,
},
["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  if not cast_data.stop_time then\n    local delay,end_time = cast_data.delay, cast_data.end_time\n    local duration\n    if end_time then\n      duration = end_time - GetTime()\n    end\n    if delay and delay ~= 0 then\n      local delay_sign = '+'\n      if delay < 0 then\n        delay_sign = ''\n      end\n      if duration and duration >= 0 then\n        return \"|cffff0000%s%s|r %.1f\",delay_sign,Round(delay,1),duration\n      else\n        return \"|cffff0000%s%s|r\",delay_sign,Round(delay,1)\n      end\n    elseif duration and duration >= 0 then\n      return \"%.1f\",duration\n    end\n  end\nend\nreturn ConfigMode()",
["location"] = "right",
["attach_to"] = "CastBar",
},
["Lua:威胁值"] = {
["exists"] = true,
["events"] = {
["UNIT_THREAT_LIST_UPDATE"] = true,
["UNIT_THREAT_SITUATION_UPDATE"] = true,
},
["code"] = "local unit_a,unit_b = ThreatPair(unit)\nif unit_a and unit_b then\n  local _,_,percent = UnitDetailedThreatSituation(unit_a, unit_b)\n  if percent and percent ~= 0 then\n    return \"%s%%\",Round(percent,1)\n  end\nend\nreturn ConfigMode()",
["location"] = "center",
["attach_to"] = "ThreatBar",
},
},
},
["目标血条"] = {
["first"] = false,
["elements"] = {
["Lua:能量"] = {
["exists"] = true,
["events"] = {
["UNIT_MAXPOWER"] = true,
["UNIT_POWER_FREQUENT"] = true,
},
["code"] = "local max = MaxPower(unit)\nif not issecretvalue(max) then\n  if max > 0 then\n    return \"%s/%s\",Power(unit),max\n  end\nelse\n  return \"%s/%s\",Power(unit),max\nend",
["location"] = "right",
["attach_to"] = "PowerBar",
},
["Lua:名称"] = {
["exists"] = true,
["events"] = {
["PLAYER_FLAGS_CHANGED"] = true,
["UNIT_NAME_UPDATE"] = true,
},
["code"] = "return '%s %s',Name(unit, true),Angle(AFK(unit) or DND(unit))",
["location"] = "out_top",
},
["Lua:施法"] = {
["exists"] = true,
["events"] = {
["UNIT_SPELLCAST_START"] = true,
["UNIT_SPELLCAST_INTERRUPTED"] = true,
["UNIT_SPELLCAST_CHANNEL_START"] = true,
["UNIT_SPELLCAST_DELAYED"] = true,
["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
["UNIT_SPELLCAST_STOP"] = true,
["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
["UNIT_SPELLCAST_FAILED"] = true,
},
["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  local spell,stop_message,target = cast_data.spell,cast_data.stop_message,cast_data.target\n  local stop_time,stop_duration = cast_data.stop_time\n  if stop_time then\n    stop_duration = GetTime() - stop_time\n  end\n  Alpha(-(stop_duration or 0) + 1)\n  if stop_message then\n    return stop_message\n  elseif target then\n    return \"%s (%s)\",spell,target\n  else\n    return spell\n  end\nend\nreturn ConfigMode()",
["location"] = "left",
["attach_to"] = "CastBar",
},
["Lua:声望"] = {
["exists"] = true,
["events"] = {
["UNIT_FACTION"] = true,
["UPDATE_FACTION"] = true,
},
["code"] = "local name, _, _, max, cur = WatchedFactionInfo()\nif not name then return ConfigMode() end\nif IsMouseOver() then\n  return name\nelse\n  return \"%d/%d (%s%%)\",cur,max,Percent(cur,max)\nend",
["location"] = "center",
["attach_to"] = "ReputationBar",
},
["Lua:PvP 计时器"] = {
["enabled"] = false,
["exists"] = true,
["events"] = {
["PLAYER_FLAGS_CHANGED"] = true,
},
["code"] = "if unit == \"player\" then\n  local pvp = PVPDuration()\n  if pvp then\n    return \"|cffff0000%s|r\",FormatDuration(pvp)\n  end\nend",
["location"] = "out_right_top",
},
["Lua:德鲁伊法力值"] = {
["exists"] = true,
["events"] = {
["UNIT_DISPLAYPOWER"] = true,
["UNIT_MAXPOWER"] = true,
["UNIT_POWER_FREQUENT"] = true,
},
["code"] = "if UnitPowerType(unit) ~= 0 then\n  return \"%s/%s\",Power(unit,0),MaxPower(unit,0)\nend",
["location"] = "center",
["attach_to"] = "AltManaBar",
},
["Lua:生命值"] = {
["exists"] = true,
["code"] = "local s = Status(unit)\nif s then\n  return s\nend\nreturn \"%s/%s || %s%%\", HP(unit), MaxHP(unit), PercentHP(unit)",
["location"] = "right",
["events"] = {
["UNIT_HEALTH"] = true,
["UNIT_MAXHEALTH"] = true,
["UNIT_AURA"] = true,
},
["attach_to"] = "HealthBar",
["size"] = 1.3,
},
["Lua:职业"] = {
["exists"] = true,
["code"] = "local dr,dg,db = DifficultyColor(unit)\nlocal form = DruidForm(unit)\nlocal classification = Classification(unit)\nif UnitIsPlayer(unit) or (not UnitIsFriend(unit,\"player\") and not IsPet(unit)) then\n  local cr,cg,cb = ClassColor(unit)\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),SmartRace(unit) or ''\n  end\nelse\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),SmartRace(unit) or ''\n  end\nend",
["location"] = "left",
["events"] = {
["UNIT_LEVEL"] = true,
["UNIT_CLASSIFICATION_CHANGED"] = true,
["UNIT_AURA"] = true,
},
["attach_to"] = "PowerBar",
["size"] = 0.6,
},
["Lua:经验值"] = {
["exists"] = true,
["events"] = {
["PLAYER_XP_UPDATE"] = true,
["UNIT_PET_EXPERIENCE"] = true,
},
["code"] = "local cur, max, rest = XP(unit), MaxXP(unit), RestXP(unit)\nif rest then\n  return \"%s/%s (%s%%) R: %s%%\",cur,max,Percent(cur,max),Percent(rest,max)\nelse\n  return \"%s/%s (%s%%)\",cur,max,Percent(cur,max)\nend",
["location"] = "center",
["attach_to"] = "ExperienceBar",
},
["Lua:施法时间"] = {
["exists"] = true,
["events"] = {
["UNIT_SPELLCAST_SUCCEEDED"] = true,
["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
["UNIT_SPELLCAST_INTERRUPTED"] = true,
["UNIT_SPELLCAST_CHANNEL_START"] = true,
["UNIT_SPELLCAST_DELAYED"] = true,
["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
["UNIT_SPELLCAST_STOP"] = true,
["UNIT_SPELLCAST_START"] = true,
["UNIT_SPELLCAST_FAILED"] = true,
},
["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  if not cast_data.stop_time then\n    local delay,end_time = cast_data.delay, cast_data.end_time\n    local duration\n    if end_time then\n      duration = end_time - GetTime()\n    end\n    if delay and delay ~= 0 then\n      local delay_sign = '+'\n      if delay < 0 then\n        delay_sign = ''\n      end\n      if duration and duration >= 0 then\n        return \"|cffff0000%s%s|r %.1f\",delay_sign,Round(delay,1),duration\n      else\n        return \"|cffff0000%s%s|r\",delay_sign,Round(delay,1)\n      end\n    elseif duration and duration >= 0 then\n      return \"%.1f\",duration\n    end\n  end\nend\nreturn ConfigMode()",
["location"] = "right",
["attach_to"] = "CastBar",
},
["Lua:威胁值"] = {
["exists"] = true,
["events"] = {
["UNIT_THREAT_LIST_UPDATE"] = true,
["UNIT_THREAT_SITUATION_UPDATE"] = true,
},
["code"] = "local unit_a,unit_b = ThreatPair(unit)\nif unit_a and unit_b then\n  local _,_,percent = UnitDetailedThreatSituation(unit_a, unit_b)\n  if percent and percent ~= 0 then\n    return \"%s%%\",Round(percent,1)\n  end\nend\nreturn ConfigMode()",
["location"] = "center",
["attach_to"] = "ThreatBar",
},
},
},
},
},
["Hunter"] = {
["layouts"] = {
["队伍的目标"] = {
["elements"] = {
["Lua:能量"] = {
["exists"] = true,
["code"] = "local max = MaxPower(unit)\nif not issecretvalue(max) then\n  if max > 0 then\n    return \"%s/%s\",Power(unit),max\n  end\nelse\n  return \"%s/%s\",Power(unit),max\nend",
["location"] = "right",
["events"] = {
["UNIT_MAXPOWER"] = true,
["UNIT_POWER_FREQUENT"] = true,
},
["attach_to"] = "PowerBar",
["size"] = 0.55,
},
["Lua:名称"] = {
["location"] = "out_top_right",
["events"] = {
["PLAYER_FLAGS_CHANGED"] = true,
["UNIT_NAME_UPDATE"] = true,
},
["exists"] = true,
["code"] = "return '%s %s',Name(unit, true),Angle(AFK(unit) or DND(unit))",
},
["Lua:施法"] = {
["events"] = {
["UNIT_SPELLCAST_START"] = true,
["UNIT_SPELLCAST_INTERRUPTED"] = true,
["UNIT_SPELLCAST_CHANNEL_START"] = true,
["UNIT_SPELLCAST_DELAYED"] = true,
["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
["UNIT_SPELLCAST_STOP"] = true,
["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
["UNIT_SPELLCAST_FAILED"] = true,
},
["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  local spell,stop_message,target = cast_data.spell,cast_data.stop_message,cast_data.target\n  local stop_time,stop_duration = cast_data.stop_time\n  if stop_time then\n    stop_duration = GetTime() - stop_time\n  end\n  Alpha(-(stop_duration or 0) + 1)\n  if stop_message then\n    return stop_message\n  elseif target then\n    return \"%s (%s)\",spell,target\n  else\n    return spell\n  end\nend\nreturn ConfigMode()",
["location"] = "left",
["attach_to"] = "CastBar",
["exists"] = true,
},
["Lua:声望"] = {
["events"] = {
["UNIT_FACTION"] = true,
["UPDATE_FACTION"] = true,
},
["code"] = "local name, _, _, max, cur = WatchedFactionInfo()\nif not name then return ConfigMode() end\nif IsMouseOver() then\n  return name\nelse\n  return \"%d/%d (%s%%)\",cur,max,Percent(cur,max)\nend",
["location"] = "center",
["attach_to"] = "ReputationBar",
["exists"] = true,
},
["Lua:PvP 计时器"] = {
["enabled"] = false,
["events"] = {
["PLAYER_FLAGS_CHANGED"] = true,
},
["code"] = "if unit == \"player\" then\n  local pvp = PVPDuration()\n  if pvp then\n    return \"|cffff0000%s|r\",FormatDuration(pvp)\n  end\nend",
["location"] = "out_right_top",
["exists"] = true,
},
["Lua:德鲁伊法力值"] = {
["events"] = {
["UNIT_DISPLAYPOWER"] = true,
["UNIT_MAXPOWER"] = true,
["UNIT_POWER_FREQUENT"] = true,
},
["code"] = "if UnitPowerType(unit) ~= 0 then\n  return \"%s/%s\",Power(unit,0),MaxPower(unit,0)\nend",
["location"] = "center",
["attach_to"] = "AltManaBar",
["exists"] = true,
},
["Lua:生命值"] = {
["events"] = {
["UNIT_MAXHEALTH"] = true,
["UNIT_HEALTH"] = true,
["UNIT_AURA"] = true,
},
["code"] = "local s = Status(unit)\nif s then\n  return s\nend\nreturn \"%s/%s\",HP(unit),MaxHP(unit)",
["location"] = "right",
["attach_to"] = "HealthBar",
["exists"] = true,
},
["Lua:职业"] = {
["exists"] = true,
["code"] = "local dr,dg,db = DifficultyColor(unit)\nlocal form = DruidForm(unit)\nlocal classification = Classification(unit)\nif UnitIsPlayer(unit) or (not UnitIsFriend(unit,\"player\") and not IsPet(unit)) then\n  local cr,cg,cb = ClassColor(unit)\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),SmartRace(unit) or ''\n  end\nelse\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),SmartRace(unit) or ''\n  end\nend",
["location"] = "left",
["events"] = {
["UNIT_LEVEL"] = true,
["UNIT_CLASSIFICATION_CHANGED"] = true,
["UNIT_AURA"] = true,
},
["attach_to"] = "PowerBar",
["size"] = 0.75,
},
["Lua:经验值"] = {
["events"] = {
["PLAYER_XP_UPDATE"] = true,
["UNIT_PET_EXPERIENCE"] = true,
},
["code"] = "local cur, max, rest = XP(unit), MaxXP(unit), RestXP(unit)\nif rest then\n  return \"%s/%s (%s%%) R: %s%%\",cur,max,Percent(cur,max),Percent(rest,max)\nelse\n  return \"%s/%s (%s%%)\",cur,max,Percent(cur,max)\nend",
["location"] = "center",
["attach_to"] = "ExperienceBar",
["exists"] = true,
},
["Lua:施法时间"] = {
["events"] = {
["UNIT_SPELLCAST_SUCCEEDED"] = true,
["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
["UNIT_SPELLCAST_INTERRUPTED"] = true,
["UNIT_SPELLCAST_CHANNEL_START"] = true,
["UNIT_SPELLCAST_DELAYED"] = true,
["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
["UNIT_SPELLCAST_STOP"] = true,
["UNIT_SPELLCAST_START"] = true,
["UNIT_SPELLCAST_FAILED"] = true,
},
["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  if not cast_data.stop_time then\n    local delay,end_time = cast_data.delay, cast_data.end_time\n    local duration\n    if end_time then\n      duration = end_time - GetTime()\n    end\n    if delay and delay ~= 0 then\n      local delay_sign = '+'\n      if delay < 0 then\n        delay_sign = ''\n      end\n      if duration and duration >= 0 then\n        return \"|cffff0000%s%s|r %.1f\",delay_sign,Round(delay,1),duration\n      else\n        return \"|cffff0000%s%s|r\",delay_sign,Round(delay,1)\n      end\n    elseif duration and duration >= 0 then\n      return \"%.1f\",duration\n    end\n  end\nend\nreturn ConfigMode()",
["location"] = "right",
["attach_to"] = "CastBar",
["exists"] = true,
},
["Lua:威胁值"] = {
["events"] = {
["UNIT_THREAT_LIST_UPDATE"] = true,
["UNIT_THREAT_SITUATION_UPDATE"] = true,
},
["code"] = "local unit_a,unit_b = ThreatPair(unit)\nif unit_a and unit_b then\n  local _,_,percent = UnitDetailedThreatSituation(unit_a, unit_b)\n  if percent and percent ~= 0 then\n    return \"%s%%\",Round(percent,1)\n  end\nend\nreturn ConfigMode()",
["location"] = "center",
["attach_to"] = "ThreatBar",
["exists"] = true,
},
},
["first"] = false,
},
["精简血条"] = {
["elements"] = {
["Lua:生命值"] = {
["exists"] = true,
["code"] = "local s = Status(unit)\nif s then\n  return s\nend\nreturn \"%s/%s\",HP(unit),MaxHP(unit)",
["location"] = "right",
["attach_to"] = "HealthBar",
["events"] = {
["UNIT_MAXHEALTH"] = true,
["UNIT_HEALTH"] = true,
["UNIT_AURA"] = true,
},
},
["Lua:名称"] = {
["location"] = "out_top_right",
["exists"] = true,
["events"] = {
["PLAYER_FLAGS_CHANGED"] = true,
["UNIT_NAME_UPDATE"] = true,
},
["code"] = "return '%s %s',Name(unit, true),Angle(AFK(unit) or DND(unit))",
},
["Lua:施法"] = {
["exists"] = true,
["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  local spell,stop_message,target = cast_data.spell,cast_data.stop_message,cast_data.target\n  local stop_time,stop_duration = cast_data.stop_time\n  if stop_time then\n    stop_duration = GetTime() - stop_time\n  end\n  Alpha(-(stop_duration or 0) + 1)\n  if stop_message then\n    return stop_message\n  elseif target then\n    return \"%s (%s)\",spell,target\n  else\n    return spell\n  end\nend\nreturn ConfigMode()",
["location"] = "left",
["attach_to"] = "CastBar",
["events"] = {
["UNIT_SPELLCAST_START"] = true,
["UNIT_SPELLCAST_INTERRUPTED"] = true,
["UNIT_SPELLCAST_CHANNEL_START"] = true,
["UNIT_SPELLCAST_DELAYED"] = true,
["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
["UNIT_SPELLCAST_STOP"] = true,
["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
["UNIT_SPELLCAST_FAILED"] = true,
},
},
["Lua:声望"] = {
["exists"] = true,
["code"] = "local name, _, _, max, cur = WatchedFactionInfo()\nif not name then return ConfigMode() end\nif IsMouseOver() then\n  return name\nelse\n  return \"%d/%d (%s%%)\",cur,max,Percent(cur,max)\nend",
["location"] = "center",
["attach_to"] = "ReputationBar",
["events"] = {
["UNIT_FACTION"] = true,
["UPDATE_FACTION"] = true,
},
},
["Lua:PvP 计时器"] = {
["enabled"] = false,
["exists"] = true,
["code"] = "if unit == \"player\" then\n  local pvp = PVPDuration()\n  if pvp then\n    return \"|cffff0000%s|r\",FormatDuration(pvp)\n  end\nend",
["location"] = "out_right_top",
["events"] = {
["PLAYER_FLAGS_CHANGED"] = true,
},
},
["Lua:威胁值"] = {
["exists"] = true,
["code"] = "local unit_a,unit_b = ThreatPair(unit)\nif unit_a and unit_b then\n  local _,_,percent = UnitDetailedThreatSituation(unit_a, unit_b)\n  if percent and percent ~= 0 then\n    return \"%s%%\",Round(percent,1)\n  end\nend\nreturn ConfigMode()",
["location"] = "center",
["attach_to"] = "ThreatBar",
["events"] = {
["UNIT_THREAT_LIST_UPDATE"] = true,
["UNIT_THREAT_SITUATION_UPDATE"] = true,
},
},
["Lua:能量"] = {
["exists"] = true,
["code"] = "local max = MaxPower(unit)\nif not issecretvalue(max) then\n  if max > 0 then\n    return \"%s/%s\",Power(unit),max\n  end\nelse\n  return \"%s/%s\",Power(unit),max\nend",
["location"] = "right",
["events"] = {
["UNIT_MAXPOWER"] = true,
["UNIT_POWER_FREQUENT"] = true,
},
["attach_to"] = "PowerBar",
["size"] = 0.55,
},
["Lua:职业"] = {
["exists"] = true,
["code"] = "local dr,dg,db = DifficultyColor(unit)\nlocal form = DruidForm(unit)\nlocal classification = Classification(unit)\nif UnitIsPlayer(unit) or (not UnitIsFriend(unit,\"player\") and not IsPet(unit)) then\n  local cr,cg,cb = ClassColor(unit)\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),SmartRace(unit) or ''\n  end\nelse\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),SmartRace(unit) or ''\n  end\nend",
["location"] = "left",
["events"] = {
["UNIT_LEVEL"] = true,
["UNIT_CLASSIFICATION_CHANGED"] = true,
["UNIT_AURA"] = true,
},
["attach_to"] = "PowerBar",
["size"] = 0.75,
},
["Lua:经验值"] = {
["exists"] = true,
["code"] = "local cur, max, rest = XP(unit), MaxXP(unit), RestXP(unit)\nif rest then\n  return \"%s/%s (%s%%) R: %s%%\",cur,max,Percent(cur,max),Percent(rest,max)\nelse\n  return \"%s/%s (%s%%)\",cur,max,Percent(cur,max)\nend",
["location"] = "center",
["attach_to"] = "ExperienceBar",
["events"] = {
["PLAYER_XP_UPDATE"] = true,
["UNIT_PET_EXPERIENCE"] = true,
},
},
["Lua:施法时间"] = {
["exists"] = true,
["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  if not cast_data.stop_time then\n    local delay,end_time = cast_data.delay, cast_data.end_time\n    local duration\n    if end_time then\n      duration = end_time - GetTime()\n    end\n    if delay and delay ~= 0 then\n      local delay_sign = '+'\n      if delay < 0 then\n        delay_sign = ''\n      end\n      if duration and duration >= 0 then\n        return \"|cffff0000%s%s|r %.1f\",delay_sign,Round(delay,1),duration\n      else\n        return \"|cffff0000%s%s|r\",delay_sign,Round(delay,1)\n      end\n    elseif duration and duration >= 0 then\n      return \"%.1f\",duration\n    end\n  end\nend\nreturn ConfigMode()",
["location"] = "right",
["attach_to"] = "CastBar",
["events"] = {
["UNIT_SPELLCAST_SUCCEEDED"] = true,
["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
["UNIT_SPELLCAST_INTERRUPTED"] = true,
["UNIT_SPELLCAST_CHANNEL_START"] = true,
["UNIT_SPELLCAST_DELAYED"] = true,
["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
["UNIT_SPELLCAST_STOP"] = true,
["UNIT_SPELLCAST_START"] = true,
["UNIT_SPELLCAST_FAILED"] = true,
},
},
["Lua:德鲁伊法力值"] = {
["exists"] = true,
["code"] = "if UnitPowerType(unit) ~= 0 then\n  return \"%s/%s\",Power(unit,0),MaxPower(unit,0)\nend",
["location"] = "center",
["attach_to"] = "AltManaBar",
["events"] = {
["UNIT_DISPLAYPOWER"] = true,
["UNIT_MAXPOWER"] = true,
["UNIT_POWER_FREQUENT"] = true,
},
},
},
["first"] = false,
},
["玩家自己血条"] = {
["elements"] = {
["Lua:能量"] = {
["exists"] = true,
["code"] = "local max = MaxPower(unit)\nif not issecretvalue(max) then\n  if max > 0 then\n    return \"%s/%s\",Power(unit),max\n  end\nelse\n  return \"%s/%s\",Power(unit),max\nend",
["location"] = "right",
["attach_to"] = "PowerBar",
["events"] = {
["UNIT_MAXPOWER"] = true,
["UNIT_POWER_FREQUENT"] = true,
},
},
["Lua:威胁值"] = {
["exists"] = true,
["code"] = "local unit_a,unit_b = ThreatPair(unit)\nif unit_a and unit_b then\n  local _,_,percent = UnitDetailedThreatSituation(unit_a, unit_b)\n  if percent and percent ~= 0 then\n    return \"%s%%\",Round(percent,1)\n  end\nend\nreturn ConfigMode()",
["location"] = "center",
["attach_to"] = "ThreatBar",
["events"] = {
["UNIT_THREAT_LIST_UPDATE"] = true,
["UNIT_THREAT_SITUATION_UPDATE"] = true,
},
},
["Lua:施法"] = {
["exists"] = true,
["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  local spell,stop_message,target = cast_data.spell,cast_data.stop_message,cast_data.target\n  local stop_time,stop_duration = cast_data.stop_time\n  if stop_time then\n    stop_duration = GetTime() - stop_time\n  end\n  Alpha(-(stop_duration or 0) + 1)\n  if stop_message then\n    return stop_message\n  elseif target then\n    return \"%s (%s)\",spell,target\n  else\n    return spell\n  end\nend\nreturn ConfigMode()",
["location"] = "left",
["attach_to"] = "CastBar",
["events"] = {
["UNIT_SPELLCAST_INTERRUPTED"] = true,
["UNIT_SPELLCAST_START"] = true,
["UNIT_SPELLCAST_CHANNEL_START"] = true,
["UNIT_SPELLCAST_DELAYED"] = true,
["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
["UNIT_SPELLCAST_STOP"] = true,
["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
["UNIT_SPELLCAST_FAILED"] = true,
},
},
["Lua:声望"] = {
["exists"] = true,
["code"] = "local name, _, _, max, cur = WatchedFactionInfo()\nif not name then return ConfigMode() end\nif IsMouseOver() then\n  return name\nelse\n  return \"%d/%d (%s%%)\",cur,max,Percent(cur,max)\nend",
["location"] = "center",
["attach_to"] = "ReputationBar",
["events"] = {
["UNIT_FACTION"] = true,
["UPDATE_FACTION"] = true,
},
},
["Lua:PvP 计时器"] = {
["enabled"] = false,
["exists"] = true,
["code"] = "if unit == \"player\" then\n  local pvp = PVPDuration()\n  if pvp then\n    return \"|cffff0000%s|r\",FormatDuration(pvp)\n  end\nend",
["location"] = "out_right_top",
["events"] = {
["PLAYER_FLAGS_CHANGED"] = true,
},
},
["Lua:德鲁伊法力值"] = {
["exists"] = true,
["code"] = "if UnitPowerType(unit) ~= 0 then\n  return \"%s/%s\",Power(unit,0),MaxPower(unit,0)\nend",
["location"] = "center",
["attach_to"] = "AltManaBar",
["events"] = {
["UNIT_DISPLAYPOWER"] = true,
["UNIT_MAXPOWER"] = true,
["UNIT_POWER_FREQUENT"] = true,
},
},
["Lua:生命值"] = {
["exists"] = true,
["code"] = "local s = Status(unit)\nif s then\n  return s\nend\nreturn \"%s/%s\",HP(unit),MaxHP(unit)",
["location"] = "right",
["events"] = {
["UNIT_MAXHEALTH"] = true,
["UNIT_HEALTH"] = true,
["UNIT_AURA"] = true,
},
["attach_to"] = "HealthBar",
["size"] = 1.65,
},
["Lua:职业"] = {
["exists"] = true,
["code"] = "local dr,dg,db = DifficultyColor(unit)\nlocal form = DruidForm(unit)\nlocal classification = Classification(unit)\nif UnitIsPlayer(unit) or (not UnitIsFriend(unit,\"player\") and not IsPet(unit)) then\n  local cr,cg,cb = ClassColor(unit)\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),SmartRace(unit) or ''\n  end\nelse\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),SmartRace(unit) or ''\n  end\nend",
["location"] = "left",
["events"] = {
["UNIT_LEVEL"] = true,
["UNIT_CLASSIFICATION_CHANGED"] = true,
["UNIT_AURA"] = true,
},
["attach_to"] = "PowerBar",
["size"] = 0.7,
},
["Lua:经验值"] = {
["exists"] = true,
["code"] = "local cur, max, rest = XP(unit), MaxXP(unit), RestXP(unit)\nif rest then\n  return \"%s/%s (%s%%) R: %s%%\",cur,max,Percent(cur,max),Percent(rest,max)\nelse\n  return \"%s/%s (%s%%)\",cur,max,Percent(cur,max)\nend",
["location"] = "center",
["attach_to"] = "ExperienceBar",
["events"] = {
["PLAYER_XP_UPDATE"] = true,
["UNIT_PET_EXPERIENCE"] = true,
},
},
["Lua:施法时间"] = {
["exists"] = true,
["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  if not cast_data.stop_time then\n    local delay,end_time = cast_data.delay, cast_data.end_time\n    local duration\n    if end_time then\n      duration = end_time - GetTime()\n    end\n    if delay and delay ~= 0 then\n      local delay_sign = '+'\n      if delay < 0 then\n        delay_sign = ''\n      end\n      if duration and duration >= 0 then\n        return \"|cffff0000%s%s|r %.1f\",delay_sign,Round(delay,1),duration\n      else\n        return \"|cffff0000%s%s|r\",delay_sign,Round(delay,1)\n      end\n    elseif duration and duration >= 0 then\n      return \"%.1f\",duration\n    end\n  end\nend\nreturn ConfigMode()",
["location"] = "right",
["attach_to"] = "CastBar",
["events"] = {
["UNIT_SPELLCAST_SUCCEEDED"] = true,
["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
["UNIT_SPELLCAST_INTERRUPTED"] = true,
["UNIT_SPELLCAST_CHANNEL_START"] = true,
["UNIT_SPELLCAST_DELAYED"] = true,
["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
["UNIT_SPELLCAST_STOP"] = true,
["UNIT_SPELLCAST_START"] = true,
["UNIT_SPELLCAST_FAILED"] = true,
},
},
["Lua:名称"] = {
["location"] = "out_top",
["exists"] = true,
["events"] = {
["PLAYER_FLAGS_CHANGED"] = true,
["UNIT_NAME_UPDATE"] = true,
},
["code"] = "return '%s %s',Name(unit, true),Angle(AFK(unit) or DND(unit))",
},
},
["first"] = false,
},
["无BUFF血条"] = {
["elements"] = {
["Lua:生命值"] = {
["enabled"] = false,
["exists"] = true,
["code"] = "local s = Status(unit)\nif s then\n  return s\nend\nreturn \"%s/%s\",HP(unit),MaxHP(unit)",
["location"] = "right",
["attach_to"] = "HealthBar",
["events"] = {
["UNIT_MAXHEALTH"] = true,
["UNIT_HEALTH"] = true,
["UNIT_AURA"] = true,
},
},
["Lua:威胁值"] = {
["enabled"] = false,
["exists"] = true,
["code"] = "local unit_a,unit_b = ThreatPair(unit)\nif unit_a and unit_b then\n  local _,_,percent = UnitDetailedThreatSituation(unit_a, unit_b)\n  if percent and percent ~= 0 then\n    return \"%s%%\",Round(percent,1)\n  end\nend\nreturn ConfigMode()",
["location"] = "center",
["attach_to"] = "ThreatBar",
["events"] = {
["UNIT_THREAT_LIST_UPDATE"] = true,
["UNIT_THREAT_SITUATION_UPDATE"] = true,
},
},
["Lua:施法"] = {
["enabled"] = false,
["exists"] = true,
["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  local spell,stop_message,target = cast_data.spell,cast_data.stop_message,cast_data.target\n  local stop_time,stop_duration = cast_data.stop_time\n  if stop_time then\n    stop_duration = GetTime() - stop_time\n  end\n  Alpha(-(stop_duration or 0) + 1)\n  if stop_message then\n    return stop_message\n  elseif target then\n    return \"%s (%s)\",spell,target\n  else\n    return spell\n  end\nend\nreturn ConfigMode()",
["location"] = "left",
["attach_to"] = "CastBar",
["events"] = {
["UNIT_SPELLCAST_START"] = true,
["UNIT_SPELLCAST_INTERRUPTED"] = true,
["UNIT_SPELLCAST_CHANNEL_START"] = true,
["UNIT_SPELLCAST_DELAYED"] = true,
["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
["UNIT_SPELLCAST_STOP"] = true,
["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
["UNIT_SPELLCAST_FAILED"] = true,
},
},
["Lua:声望"] = {
["enabled"] = false,
["exists"] = true,
["code"] = "local name, _, _, max, cur = WatchedFactionInfo()\nif not name then return ConfigMode() end\nif IsMouseOver() then\n  return name\nelse\n  return \"%d/%d (%s%%)\",cur,max,Percent(cur,max)\nend",
["location"] = "center",
["attach_to"] = "ReputationBar",
["events"] = {
["UNIT_FACTION"] = true,
["UPDATE_FACTION"] = true,
},
},
["Lua:PvP 计时器"] = {
["enabled"] = false,
["exists"] = true,
["code"] = "if unit == \"player\" then\n  local pvp = PVPDuration()\n  if pvp then\n    return \"|cffff0000%s|r\",FormatDuration(pvp)\n  end\nend",
["location"] = "out_right_top",
["events"] = {
["PLAYER_FLAGS_CHANGED"] = true,
},
},
["Lua:名称"] = {
["exists"] = true,
["code"] = "return '%s %s',Name(unit, true),Angle(AFK(unit) or DND(unit))",
["location"] = "right",
["position"] = 1.00001,
["attach_to"] = "HealthBar",
["events"] = {
["PLAYER_FLAGS_CHANGED"] = true,
["UNIT_NAME_UPDATE"] = true,
},
},
["Lua:能量"] = {
["enabled"] = false,
["exists"] = true,
["code"] = "local max = MaxPower(unit)\nif not issecretvalue(max) then\n  if max > 0 then\n    return \"%s/%s\",Power(unit),max\n  end\nelse\n  return \"%s/%s\",Power(unit),max\nend",
["location"] = "right",
["events"] = {
["UNIT_MAXPOWER"] = true,
["UNIT_POWER_FREQUENT"] = true,
},
["attach_to"] = "PowerBar",
["size"] = 0.75,
},
["Lua:职业"] = {
["enabled"] = false,
["exists"] = true,
["code"] = "local dr,dg,db = DifficultyColor(unit)\nlocal form = DruidForm(unit)\nlocal classification = Classification(unit)\nif UnitIsPlayer(unit) or (not UnitIsFriend(unit,\"player\") and not IsPet(unit)) then\n  local cr,cg,cb = ClassColor(unit)\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),SmartRace(unit) or ''\n  end\nelse\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),SmartRace(unit) or ''\n  end\nend",
["location"] = "left",
["attach_to"] = "PowerBar",
["events"] = {
["UNIT_LEVEL"] = true,
["UNIT_CLASSIFICATION_CHANGED"] = true,
["UNIT_AURA"] = true,
},
},
["Lua:经验值"] = {
["enabled"] = false,
["exists"] = true,
["code"] = "local cur, max, rest = XP(unit), MaxXP(unit), RestXP(unit)\nif rest then\n  return \"%s/%s (%s%%) R: %s%%\",cur,max,Percent(cur,max),Percent(rest,max)\nelse\n  return \"%s/%s (%s%%)\",cur,max,Percent(cur,max)\nend",
["location"] = "center",
["attach_to"] = "ExperienceBar",
["events"] = {
["PLAYER_XP_UPDATE"] = true,
["UNIT_PET_EXPERIENCE"] = true,
},
},
["Lua:施法时间"] = {
["enabled"] = false,
["exists"] = true,
["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  if not cast_data.stop_time then\n    local delay,end_time = cast_data.delay, cast_data.end_time\n    local duration\n    if end_time then\n      duration = end_time - GetTime()\n    end\n    if delay and delay ~= 0 then\n      local delay_sign = '+'\n      if delay < 0 then\n        delay_sign = ''\n      end\n      if duration and duration >= 0 then\n        return \"|cffff0000%s%s|r %.1f\",delay_sign,Round(delay,1),duration\n      else\n        return \"|cffff0000%s%s|r\",delay_sign,Round(delay,1)\n      end\n    elseif duration and duration >= 0 then\n      return \"%.1f\",duration\n    end\n  end\nend\nreturn ConfigMode()",
["location"] = "right",
["attach_to"] = "CastBar",
["events"] = {
["UNIT_SPELLCAST_SUCCEEDED"] = true,
["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
["UNIT_SPELLCAST_INTERRUPTED"] = true,
["UNIT_SPELLCAST_CHANNEL_START"] = true,
["UNIT_SPELLCAST_DELAYED"] = true,
["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
["UNIT_SPELLCAST_STOP"] = true,
["UNIT_SPELLCAST_START"] = true,
["UNIT_SPELLCAST_FAILED"] = true,
},
},
["Lua:德鲁伊法力值"] = {
["enabled"] = false,
["exists"] = true,
["code"] = "if UnitPowerType(unit) ~= 0 then\n  return \"%s/%s\",Power(unit,0),MaxPower(unit,0)\nend",
["location"] = "center",
["attach_to"] = "AltManaBar",
["events"] = {
["UNIT_DISPLAYPOWER"] = true,
["UNIT_MAXPOWER"] = true,
["UNIT_POWER_FREQUENT"] = true,
},
},
},
["first"] = false,
},
["目标血条"] = {
["elements"] = {
["Lua:能量"] = {
["exists"] = true,
["code"] = "local max = MaxPower(unit)\nif not issecretvalue(max) then\n  if max > 0 then\n    return \"%s/%s\",Power(unit),max\n  end\nelse\n  return \"%s/%s\",Power(unit),max\nend",
["location"] = "right",
["attach_to"] = "PowerBar",
["events"] = {
["UNIT_MAXPOWER"] = true,
["UNIT_POWER_FREQUENT"] = true,
},
},
["Lua:名称"] = {
["location"] = "out_top",
["exists"] = true,
["events"] = {
["PLAYER_FLAGS_CHANGED"] = true,
["UNIT_NAME_UPDATE"] = true,
},
["code"] = "return '%s %s',Name(unit, true),Angle(AFK(unit) or DND(unit))",
},
["Lua:施法"] = {
["exists"] = true,
["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  local spell,stop_message,target = cast_data.spell,cast_data.stop_message,cast_data.target\n  local stop_time,stop_duration = cast_data.stop_time\n  if stop_time then\n    stop_duration = GetTime() - stop_time\n  end\n  Alpha(-(stop_duration or 0) + 1)\n  if stop_message then\n    return stop_message\n  elseif target then\n    return \"%s (%s)\",spell,target\n  else\n    return spell\n  end\nend\nreturn ConfigMode()",
["location"] = "left",
["attach_to"] = "CastBar",
["events"] = {
["UNIT_SPELLCAST_START"] = true,
["UNIT_SPELLCAST_INTERRUPTED"] = true,
["UNIT_SPELLCAST_CHANNEL_START"] = true,
["UNIT_SPELLCAST_DELAYED"] = true,
["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
["UNIT_SPELLCAST_STOP"] = true,
["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
["UNIT_SPELLCAST_FAILED"] = true,
},
},
["Lua:声望"] = {
["exists"] = true,
["code"] = "local name, _, _, max, cur = WatchedFactionInfo()\nif not name then return ConfigMode() end\nif IsMouseOver() then\n  return name\nelse\n  return \"%d/%d (%s%%)\",cur,max,Percent(cur,max)\nend",
["location"] = "center",
["attach_to"] = "ReputationBar",
["events"] = {
["UNIT_FACTION"] = true,
["UPDATE_FACTION"] = true,
},
},
["Lua:PvP 计时器"] = {
["enabled"] = false,
["exists"] = true,
["code"] = "if unit == \"player\" then\n  local pvp = PVPDuration()\n  if pvp then\n    return \"|cffff0000%s|r\",FormatDuration(pvp)\n  end\nend",
["location"] = "out_right_top",
["events"] = {
["PLAYER_FLAGS_CHANGED"] = true,
},
},
["Lua:德鲁伊法力值"] = {
["exists"] = true,
["code"] = "if UnitPowerType(unit) ~= 0 then\n  return \"%s/%s\",Power(unit,0),MaxPower(unit,0)\nend",
["location"] = "center",
["attach_to"] = "AltManaBar",
["events"] = {
["UNIT_DISPLAYPOWER"] = true,
["UNIT_MAXPOWER"] = true,
["UNIT_POWER_FREQUENT"] = true,
},
},
["Lua:生命值"] = {
["exists"] = true,
["code"] = "local s = Status(unit)\nif s then\n  return s\nend\nreturn \"%s/%s || %s%%\", HP(unit), MaxHP(unit), PercentHP(unit)",
["location"] = "right",
["events"] = {
["UNIT_HEALTH"] = true,
["UNIT_MAXHEALTH"] = true,
["UNIT_AURA"] = true,
},
["attach_to"] = "HealthBar",
["size"] = 1.3,
},
["Lua:职业"] = {
["exists"] = true,
["code"] = "local dr,dg,db = DifficultyColor(unit)\nlocal form = DruidForm(unit)\nlocal classification = Classification(unit)\nif UnitIsPlayer(unit) or (not UnitIsFriend(unit,\"player\") and not IsPet(unit)) then\n  local cr,cg,cb = ClassColor(unit)\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),SmartRace(unit) or ''\n  end\nelse\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),SmartRace(unit) or ''\n  end\nend",
["location"] = "left",
["events"] = {
["UNIT_LEVEL"] = true,
["UNIT_CLASSIFICATION_CHANGED"] = true,
["UNIT_AURA"] = true,
},
["attach_to"] = "PowerBar",
["size"] = 0.6,
},
["Lua:经验值"] = {
["exists"] = true,
["code"] = "local cur, max, rest = XP(unit), MaxXP(unit), RestXP(unit)\nif rest then\n  return \"%s/%s (%s%%) R: %s%%\",cur,max,Percent(cur,max),Percent(rest,max)\nelse\n  return \"%s/%s (%s%%)\",cur,max,Percent(cur,max)\nend",
["location"] = "center",
["attach_to"] = "ExperienceBar",
["events"] = {
["PLAYER_XP_UPDATE"] = true,
["UNIT_PET_EXPERIENCE"] = true,
},
},
["Lua:施法时间"] = {
["exists"] = true,
["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  if not cast_data.stop_time then\n    local delay,end_time = cast_data.delay, cast_data.end_time\n    local duration\n    if end_time then\n      duration = end_time - GetTime()\n    end\n    if delay and delay ~= 0 then\n      local delay_sign = '+'\n      if delay < 0 then\n        delay_sign = ''\n      end\n      if duration and duration >= 0 then\n        return \"|cffff0000%s%s|r %.1f\",delay_sign,Round(delay,1),duration\n      else\n        return \"|cffff0000%s%s|r\",delay_sign,Round(delay,1)\n      end\n    elseif duration and duration >= 0 then\n      return \"%.1f\",duration\n    end\n  end\nend\nreturn ConfigMode()",
["location"] = "right",
["attach_to"] = "CastBar",
["events"] = {
["UNIT_SPELLCAST_SUCCEEDED"] = true,
["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
["UNIT_SPELLCAST_INTERRUPTED"] = true,
["UNIT_SPELLCAST_CHANNEL_START"] = true,
["UNIT_SPELLCAST_DELAYED"] = true,
["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
["UNIT_SPELLCAST_STOP"] = true,
["UNIT_SPELLCAST_START"] = true,
["UNIT_SPELLCAST_FAILED"] = true,
},
},
["Lua:威胁值"] = {
["exists"] = true,
["code"] = "local unit_a,unit_b = ThreatPair(unit)\nif unit_a and unit_b then\n  local _,_,percent = UnitDetailedThreatSituation(unit_a, unit_b)\n  if percent and percent ~= 0 then\n    return \"%s%%\",Round(percent,1)\n  end\nend\nreturn ConfigMode()",
["location"] = "center",
["attach_to"] = "ThreatBar",
["events"] = {
["UNIT_THREAT_LIST_UPDATE"] = true,
["UNIT_THREAT_SITUATION_UPDATE"] = true,
},
},
},
["first"] = false,
},
["普通"] = {
["elements"] = {
["Lua:能量"] = {
["exists"] = true,
["code"] = "local max = MaxPower(unit)\nif not issecretvalue(max) then\n  if max > 0 then\n    return \"%s/%s\",Power(unit),max\n  end\nelse\n  return \"%s/%s\",Power(unit),max\nend",
["location"] = "right",
["attach_to"] = "PowerBar",
["events"] = {
["UNIT_MAXPOWER"] = true,
["UNIT_POWER_FREQUENT"] = true,
},
},
["Lua:名称"] = {
["exists"] = true,
["code"] = "return '%s %s',Name(unit, true),Angle(AFK(unit) or DND(unit))",
["location"] = "left",
["attach_to"] = "HealthBar",
["events"] = {
["PLAYER_FLAGS_CHANGED"] = true,
["UNIT_NAME_UPDATE"] = true,
},
},
["Lua:施法"] = {
["exists"] = true,
["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  local spell,stop_message,target = cast_data.spell,cast_data.stop_message,cast_data.target\n  local stop_time,stop_duration = cast_data.stop_time\n  if stop_time then\n    stop_duration = GetTime() - stop_time\n  end\n  Alpha(-(stop_duration or 0) + 1)\n  if stop_message then\n    return stop_message\n  elseif target then\n    return \"%s (%s)\",spell,target\n  else\n    return spell\n  end\nend\nreturn ConfigMode()",
["location"] = "left",
["attach_to"] = "CastBar",
["events"] = {
["UNIT_SPELLCAST_INTERRUPTED"] = true,
["UNIT_SPELLCAST_START"] = true,
["UNIT_SPELLCAST_CHANNEL_START"] = true,
["UNIT_SPELLCAST_DELAYED"] = true,
["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
["UNIT_SPELLCAST_STOP"] = true,
["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
["UNIT_SPELLCAST_FAILED"] = true,
},
},
["Lua:声望"] = {
["exists"] = true,
["code"] = "local name, _, _, max, cur = WatchedFactionInfo()\nif not name then return ConfigMode() end\nif IsMouseOver() then\n  return name\nelse\n  return \"%d/%d (%s%%)\",cur,max,Percent(cur,max)\nend",
["location"] = "center",
["attach_to"] = "ReputationBar",
["events"] = {
["UNIT_FACTION"] = true,
["UPDATE_FACTION"] = true,
},
},
["Lua:PvP 计时器"] = {
["location"] = "out_right_top",
["exists"] = true,
["events"] = {
["PLAYER_FLAGS_CHANGED"] = true,
},
["code"] = "if unit == \"player\" then\n  local pvp = PVPDuration()\n  if pvp then\n    return \"|cffff0000%s|r\",FormatDuration(pvp)\n  end\nend",
},
["Lua:德鲁伊法力值"] = {
["exists"] = true,
["code"] = "if UnitPowerType(unit) ~= 0 then\n  return \"%s/%s\",Power(unit,0),MaxPower(unit,0)\nend",
["location"] = "center",
["attach_to"] = "AltManaBar",
["events"] = {
["UNIT_DISPLAYPOWER"] = true,
["UNIT_MAXPOWER"] = true,
["UNIT_POWER_FREQUENT"] = true,
},
},
["Lua:生命值"] = {
["exists"] = true,
["code"] = "local s = Status(unit)\nif s then\n  return s\nend\nreturn \"%s/%s || %s%%\",Short(HP(unit)),Short(MaxHP(unit)),PercentHP(unit)",
["location"] = "right",
["attach_to"] = "HealthBar",
["events"] = {
["UNIT_HEALTH"] = true,
["UNIT_MAXHEALTH"] = true,
["UNIT_AURA"] = true,
},
},
["Lua:职业"] = {
["exists"] = true,
["code"] = "local dr,dg,db = DifficultyColor(unit)\nlocal form = DruidForm(unit)\nlocal classification = Classification(unit)\nif UnitIsPlayer(unit) or (not UnitIsFriend(unit,\"player\") and not IsPet(unit)) then\n  local cr,cg,cb = ClassColor(unit)\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),SmartRace(unit) or ''\n  end\nelse\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),SmartRace(unit) or ''\n  end\nend",
["location"] = "left",
["events"] = {
["UNIT_LEVEL"] = true,
["UNIT_CLASSIFICATION_CHANGED"] = true,
["UNIT_AURA"] = true,
},
["attach_to"] = "PowerBar",
["size"] = 0.8500000000000001,
},
["Lua:经验值"] = {
["exists"] = true,
["code"] = "local cur, max, rest = XP(unit), MaxXP(unit), RestXP(unit)\nif rest then\n  return \"%s/%s (%s%%) R: %s%%\",cur,max,Percent(cur,max),Percent(rest,max)\nelse\n  return \"%s/%s (%s%%)\",cur,max,Percent(cur,max)\nend",
["location"] = "center",
["attach_to"] = "ExperienceBar",
["events"] = {
["PLAYER_XP_UPDATE"] = true,
["UNIT_PET_EXPERIENCE"] = true,
},
},
["Lua:施法时间"] = {
["exists"] = true,
["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  if not cast_data.stop_time then\n    local delay,end_time = cast_data.delay, cast_data.end_time\n    local duration\n    if end_time then\n      duration = end_time - GetTime()\n    end\n    if delay and delay ~= 0 then\n      local delay_sign = '+'\n      if delay < 0 then\n        delay_sign = ''\n      end\n      if duration and duration >= 0 then\n        return \"|cffff0000%s%s|r %.1f\",delay_sign,Round(delay,1),duration\n      else\n        return \"|cffff0000%s%s|r\",delay_sign,Round(delay,1)\n      end\n    elseif duration and duration >= 0 then\n      return \"%.1f\",duration\n    end\n  end\nend\nreturn ConfigMode()",
["location"] = "right",
["attach_to"] = "CastBar",
["events"] = {
["UNIT_SPELLCAST_SUCCEEDED"] = true,
["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
["UNIT_SPELLCAST_INTERRUPTED"] = true,
["UNIT_SPELLCAST_CHANNEL_START"] = true,
["UNIT_SPELLCAST_DELAYED"] = true,
["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
["UNIT_SPELLCAST_STOP"] = true,
["UNIT_SPELLCAST_START"] = true,
["UNIT_SPELLCAST_FAILED"] = true,
},
},
["Lua:威胁值"] = {
["exists"] = true,
["code"] = "local unit_a,unit_b = ThreatPair(unit)\nif unit_a and unit_b then\n  local _,_,percent = UnitDetailedThreatSituation(unit_a, unit_b)\n  if percent and percent ~= 0 then\n    return \"%s%%\",Round(percent,1)\n  end\nend\nreturn ConfigMode()",
["location"] = "center",
["attach_to"] = "ThreatBar",
["events"] = {
["UNIT_THREAT_LIST_UPDATE"] = true,
["UNIT_THREAT_SITUATION_UPDATE"] = true,
},
},
},
["first"] = false,
},
["宠物血条"] = {
["elements"] = {
["Lua:能量"] = {
["exists"] = true,
["code"] = "local max = MaxPower(unit)\nif not issecretvalue(max) then\n  if max > 0 then\n    return \"%s/%s\",Power(unit),max\n  end\nelse\n  return \"%s/%s\",Power(unit),max\nend",
["location"] = "right",
["events"] = {
["UNIT_MAXPOWER"] = true,
["UNIT_POWER_FREQUENT"] = true,
},
["attach_to"] = "PowerBar",
["size"] = 0.75,
},
["Lua:威胁值"] = {
["exists"] = true,
["code"] = "local unit_a,unit_b = ThreatPair(unit)\nif unit_a and unit_b then\n  local _,_,percent = UnitDetailedThreatSituation(unit_a, unit_b)\n  if percent and percent ~= 0 then\n    return \"%s%%\",Round(percent,1)\n  end\nend\nreturn ConfigMode()",
["location"] = "center",
["attach_to"] = "ThreatBar",
["events"] = {
["UNIT_THREAT_LIST_UPDATE"] = true,
["UNIT_THREAT_SITUATION_UPDATE"] = true,
},
},
["Lua:施法"] = {
["exists"] = true,
["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  local spell,stop_message,target = cast_data.spell,cast_data.stop_message,cast_data.target\n  local stop_time,stop_duration = cast_data.stop_time\n  if stop_time then\n    stop_duration = GetTime() - stop_time\n  end\n  Alpha(-(stop_duration or 0) + 1)\n  if stop_message then\n    return stop_message\n  elseif target then\n    return \"%s (%s)\",spell,target\n  else\n    return spell\n  end\nend\nreturn ConfigMode()",
["location"] = "left",
["attach_to"] = "CastBar",
["events"] = {
["UNIT_SPELLCAST_INTERRUPTED"] = true,
["UNIT_SPELLCAST_START"] = true,
["UNIT_SPELLCAST_CHANNEL_START"] = true,
["UNIT_SPELLCAST_DELAYED"] = true,
["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
["UNIT_SPELLCAST_STOP"] = true,
["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
["UNIT_SPELLCAST_FAILED"] = true,
},
},
["Lua:声望"] = {
["exists"] = true,
["code"] = "local name, _, _, max, cur = WatchedFactionInfo()\nif not name then return ConfigMode() end\nif IsMouseOver() then\n  return name\nelse\n  return \"%d/%d (%s%%)\",cur,max,Percent(cur,max)\nend",
["location"] = "center",
["attach_to"] = "ReputationBar",
["events"] = {
["UNIT_FACTION"] = true,
["UPDATE_FACTION"] = true,
},
},
["Lua:PvP 计时器"] = {
["enabled"] = false,
["exists"] = true,
["code"] = "if unit == \"player\" then\n  local pvp = PVPDuration()\n  if pvp then\n    return \"|cffff0000%s|r\",FormatDuration(pvp)\n  end\nend",
["location"] = "out_right_top",
["events"] = {
["PLAYER_FLAGS_CHANGED"] = true,
},
},
["Lua:德鲁伊法力值"] = {
["exists"] = true,
["code"] = "if UnitPowerType(unit) ~= 0 then\n  return \"%s/%s\",Power(unit,0),MaxPower(unit,0)\nend",
["location"] = "center",
["attach_to"] = "AltManaBar",
["events"] = {
["UNIT_DISPLAYPOWER"] = true,
["UNIT_MAXPOWER"] = true,
["UNIT_POWER_FREQUENT"] = true,
},
},
["Lua:生命值"] = {
["exists"] = true,
["code"] = "local s = Status(unit)\nif s then\n  return s\nend\nreturn \"%s/%s\",HP(unit),MaxHP(unit)",
["location"] = "right",
["attach_to"] = "HealthBar",
["events"] = {
["UNIT_MAXHEALTH"] = true,
["UNIT_HEALTH"] = true,
["UNIT_AURA"] = true,
},
},
["Lua:职业"] = {
["enabled"] = false,
["exists"] = true,
["code"] = "local dr,dg,db = DifficultyColor(unit)\nlocal form = DruidForm(unit)\nlocal classification = Classification(unit)\nif UnitIsPlayer(unit) or (not UnitIsFriend(unit,\"player\") and not IsPet(unit)) then\n  local cr,cg,cb = ClassColor(unit)\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r |cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),cr,cg,cb,Class(unit),SmartRace(unit) or ''\n  end\nelse\n  if form then\n    return \"%s%s|cff%02x%02x%02x%s|r (%s) %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),form,SmartRace(unit) or ''\n  else\n    return \"%s%s|cff%02x%02x%02x%s|r %s\",classification or '',classification and ' ' or '',dr,dg,db,Level(unit),SmartRace(unit) or ''\n  end\nend",
["location"] = "left",
["attach_to"] = "PowerBar",
["events"] = {
["UNIT_LEVEL"] = true,
["UNIT_CLASSIFICATION_CHANGED"] = true,
["UNIT_AURA"] = true,
},
},
["Lua:经验值"] = {
["exists"] = true,
["code"] = "local cur, max, rest = XP(unit), MaxXP(unit), RestXP(unit)\nif rest then\n  return \"%s/%s (%s%%) R: %s%%\",cur,max,Percent(cur,max),Percent(rest,max)\nelse\n  return \"%s/%s (%s%%)\",cur,max,Percent(cur,max)\nend",
["location"] = "center",
["attach_to"] = "ExperienceBar",
["events"] = {
["PLAYER_XP_UPDATE"] = true,
["UNIT_PET_EXPERIENCE"] = true,
},
},
["Lua:施法时间"] = {
["exists"] = true,
["code"] = "local cast_data = CastData(unit)\nif cast_data then\n  if not cast_data.stop_time then\n    local delay,end_time = cast_data.delay, cast_data.end_time\n    local duration\n    if end_time then\n      duration = end_time - GetTime()\n    end\n    if delay and delay ~= 0 then\n      local delay_sign = '+'\n      if delay < 0 then\n        delay_sign = ''\n      end\n      if duration and duration >= 0 then\n        return \"|cffff0000%s%s|r %.1f\",delay_sign,Round(delay,1),duration\n      else\n        return \"|cffff0000%s%s|r\",delay_sign,Round(delay,1)\n      end\n    elseif duration and duration >= 0 then\n      return \"%.1f\",duration\n    end\n  end\nend\nreturn ConfigMode()",
["location"] = "right",
["attach_to"] = "CastBar",
["events"] = {
["UNIT_SPELLCAST_SUCCEEDED"] = true,
["UNIT_SPELLCAST_CHANNEL_UPDATE"] = true,
["UNIT_SPELLCAST_INTERRUPTED"] = true,
["UNIT_SPELLCAST_CHANNEL_START"] = true,
["UNIT_SPELLCAST_DELAYED"] = true,
["UNIT_SPELLCAST_CHANNEL_STOP"] = true,
["UNIT_SPELLCAST_STOP"] = true,
["UNIT_SPELLCAST_START"] = true,
["UNIT_SPELLCAST_FAILED"] = true,
},
},
["Lua:名称"] = {
["enabled"] = false,
["exists"] = true,
["code"] = "return '%s %s',Name(unit),Angle(AFK(unit) or DND(unit))",
["location"] = "out_right",
["attach_to"] = "HealthBar",
["events"] = {
["PLAYER_FLAGS_CHANGED"] = true,
["UNIT_NAME_UPDATE"] = true,
},
},
},
["first"] = false,
},
},
},
},
},
["SummonIcon"] = {
["profiles"] = {
["Default"] = {
["layouts"] = {
["队伍的目标"] = {
["position"] = 1.00001,
},
["玩家自己血条"] = {
["position"] = 1.00001,
},
["宠物血条"] = {
["position"] = 1.00001,
},
["目标血条"] = {
["position"] = 1.00001,
},
},
},
["Hunter"] = {
["layouts"] = {
["宠物血条"] = {
["position"] = 1.00001,
},
["目标血条"] = {
["position"] = 1.00001,
},
["玩家自己血条"] = {
["position"] = 1.00001,
},
},
},
},
},
["CombatText"] = {
["profiles"] = {
["Default"] = {
["layouts"] = {
["队伍的目标"] = {
["enabled"] = false,
["position"] = 1.00002,
},
["精简血条"] = {
["position"] = 1.00001,
},
["玩家自己血条"] = {
["position"] = 1.00002,
},
["无BUFF血条"] = {
["enabled"] = false,
["position"] = 1.00001,
},
["宠物血条"] = {
["enabled"] = false,
["position"] = 1.00002,
},
["普通"] = {
["position"] = 1.00001,
},
["目标血条"] = {
["position"] = 1.00002,
},
},
},
["Hunter"] = {
["layouts"] = {
["队伍的目标"] = {
["position"] = 1.00001,
},
["宠物血条"] = {
["enabled"] = false,
["position"] = 1.00002,
},
["玩家自己血条"] = {
["position"] = 1.00002,
},
["无BUFF血条"] = {
["enabled"] = false,
["position"] = 1.00001,
},
["目标血条"] = {
["position"] = 1.00002,
},
["普通"] = {
["position"] = 1.00001,
},
["精简血条"] = {
["position"] = 1.00001,
},
},
},
},
},
["ReadyCheckIcon"] = {
["profiles"] = {
["Default"] = {
["layouts"] = {
["队伍的目标"] = {
["position"] = 1.00001,
},
["宠物血条"] = {
["enabled"] = false,
["position"] = 1.00002,
},
["玩家自己血条"] = {
["position"] = 1.00002,
},
["无BUFF血条"] = {
["enabled"] = false,
["position"] = 1.00001,
},
["精简血条"] = {
["position"] = 1.00001,
},
["目标血条"] = {
["position"] = 1.00001,
},
["标准"] = {
["position"] = 1.00002,
},
},
},
["Hunter"] = {
["layouts"] = {
["队伍的目标"] = {
["position"] = 1.00001,
},
["玩家自己血条"] = {
["position"] = 1.00001,
},
["无BUFF血条"] = {
["enabled"] = false,
["position"] = 1.00001,
},
["精简血条"] = {
["position"] = 1.00001,
},
["目标血条"] = {
["position"] = 1.00001,
},
["宠物血条"] = {
["enabled"] = false,
["position"] = 1.00002,
},
},
},
},
},
["Totems"] = {
["profiles"] = {
["Default"] = {
},
["Hunter"] = {
},
},
},
["Portrait"] = {
["profiles"] = {
["Default"] = {
["layouts"] = {
["队伍的目标"] = {
["enabled"] = true,
["fallback_style"] = "class",
["style"] = "class",
},
["玩家自己血条"] = {
["enabled"] = true,
["fallback_style"] = "class",
["style"] = "two_dimensional",
["position"] = 1.00001,
},
["无BUFF血条"] = {
["enabled"] = true,
["fallback_style"] = "class",
["style"] = "class",
},
["宠物血条"] = {
["enabled"] = true,
["fallback_style"] = "class",
["side"] = "right",
["style"] = "class",
},
["精简血条"] = {
["enabled"] = true,
["fallback_style"] = "class",
["style"] = "class",
},
["目标血条"] = {
["enabled"] = true,
["side"] = "right",
["fallback_style"] = "class",
["style"] = "two_dimensional",
},
},
},
["Hunter"] = {
["layouts"] = {
["队伍的目标"] = {
["enabled"] = true,
["fallback_style"] = "class",
["style"] = "class",
},
["玩家自己血条"] = {
["enabled"] = true,
["fallback_style"] = "class",
["style"] = "two_dimensional",
},
["无BUFF血条"] = {
["enabled"] = true,
["fallback_style"] = "class",
["style"] = "class",
},
["精简血条"] = {
["enabled"] = true,
["fallback_style"] = "class",
["style"] = "class",
},
["目标血条"] = {
["enabled"] = true,
["side"] = "right",
["fallback_style"] = "class",
["style"] = "two_dimensional",
},
["宠物血条"] = {
["enabled"] = true,
["fallback_style"] = "class",
["side"] = "right",
["style"] = "class",
},
},
},
},
},
["ExperienceBar"] = {
["profiles"] = {
["Default"] = {
["layouts"] = {
["队伍的目标"] = {
["enabled"] = false,
},
["玩家自己血条"] = {
["enabled"] = false,
},
["无BUFF血条"] = {
["enabled"] = false,
},
["目标血条"] = {
["enabled"] = false,
},
["精简血条"] = {
["enabled"] = false,
},
["宠物血条"] = {
["enabled"] = false,
},
},
["global"] = {
["enabled"] = false,
},
},
["Hunter"] = {
["layouts"] = {
["队伍的目标"] = {
["enabled"] = false,
},
["玩家自己血条"] = {
["enabled"] = false,
},
["无BUFF血条"] = {
["enabled"] = false,
},
["目标血条"] = {
["enabled"] = false,
},
["精简血条"] = {
["enabled"] = false,
},
["宠物血条"] = {
["enabled"] = false,
},
},
["global"] = {
["enabled"] = false,
},
},
},
},
["CapsuleSkin"] = {
["profiles"] = {
["Default"] = {
["layouts"] = {
["队伍的目标"] = {
["mask_portrait"] = false,
["shape"] = "left_cap",
["border_thickness"] = "thick",
},
["玩家自己血条"] = {
["dragon_style"] = "winged_gold",
["dragon_scale"] = 1.15,
["border_color"] = {
0.4705882370471954,
0.4705882370471954,
0.4705882370471954,
1,
},
["portrait_border"] = true,
["border_offset"] = 1,
["dragon_x"] = -8,
["shape"] = "left_cap",
["dragon_flip"] = true,
},
["无BUFF血条"] = {
["dragon_scale"] = 1.05,
["border_color"] = {
0.4549019634723663,
0.47843137383461,
0.5137255191802979,
1,
},
["border_offset"] = -0.5,
["portrait_border"] = true,
["portrait_x"] = -20,
["shape"] = "right_cap",
["border_thickness"] = "thick",
},
["宠物血条"] = {
["dragon_style"] = "winged_gold",
["elite_dragon"] = false,
["dragon_scale"] = 1.05,
["border_color"] = {
0.5215686559677124,
0.5490196347236633,
0.5882353186607361,
0.949999988079071,
},
["border_offset"] = 1,
["dragon_x"] = 6,
["shape"] = "left_cap",
},
["精简血条"] = {
["mask_portrait"] = false,
["border_color"] = {
0.4666666686534882,
0.4901960790157318,
0.5254902243614197,
0.949999988079071,
},
["shape"] = "left_cap",
["border_thickness"] = "thick",
},
["目标血条"] = {
["elite_border_tint"] = true,
["dragon_scale"] = 1.1,
["border_color"] = {
0.4666666686534882,
0.4666666686534882,
0.4666666686534882,
0.949999988079071,
},
["portrait_scale"] = 1.2,
["portrait_border"] = true,
["border_offset"] = 1,
["portrait_x"] = 2,
["shape"] = "right_cap",
["dragon_x"] = 1,
},
},
},
["Hunter"] = {
["layouts"] = {
["队伍的目标"] = {
["shape"] = "left_cap",
["border_thickness"] = "thick",
["mask_portrait"] = false,
},
["玩家自己血条"] = {
["dragon_scale"] = 1.1,
["border_color"] = {
0.4705882370471954,
0.4705882370471954,
0.4705882370471954,
1,
},
["dragon_style"] = "silver",
["border_offset"] = 1,
["portrait_border"] = true,
["portrait_scale"] = 1.2,
["shape"] = "left_cap",
["dragon_flip"] = true,
["dragon_x"] = -3,
},
["无BUFF血条"] = {
["border_offset"] = -0.5,
["portrait_border"] = true,
["dragon_scale"] = 1.05,
["border_color"] = {
0.4549019634723663,
0.47843137383461,
0.5137255191802979,
1,
},
["portrait_x"] = -20,
["shape"] = "right_cap",
["border_thickness"] = "thick",
},
["宠物血条"] = {
["border_offset"] = 1,
["elite_dragon"] = false,
["dragon_scale"] = 1.05,
["border_color"] = {
0.5215686559677124,
0.5490196347236633,
0.5882353186607361,
0.949999988079071,
},
["dragon_x"] = 6,
["shape"] = "left_cap",
["dragon_style"] = "winged_gold",
},
["精简血条"] = {
["border_color"] = {
0.4666666686534882,
0.4901960790157318,
0.5254902243614197,
0.949999988079071,
},
["shape"] = "left_cap",
["border_thickness"] = "thick",
["mask_portrait"] = false,
},
["目标血条"] = {
["dragon_scale"] = 1.1,
["border_color"] = {
0.4666666686534882,
0.4666666686534882,
0.4666666686534882,
0.949999988079071,
},
["elite_border_tint"] = true,
["portrait_scale"] = 1.2,
["portrait_border"] = true,
["border_offset"] = 1,
["portrait_x"] = 2,
["shape"] = "right_cap",
["dragon_x"] = 1,
},
},
},
},
},
["CastBar"] = {
["profiles"] = {
["Default"] = {
["layouts"] = {
["队伍的目标"] = {
["enabled"] = false,
},
["玩家自己血条"] = {
["enabled"] = false,
},
["无BUFF血条"] = {
["enabled"] = false,
},
["目标血条"] = {
["enabled"] = false,
},
["精简血条"] = {
["enabled"] = false,
},
["宠物血条"] = {
["enabled"] = false,
},
},
["global"] = {
["enabled"] = false,
},
},
["Hunter"] = {
["layouts"] = {
["队伍的目标"] = {
["enabled"] = false,
},
["玩家自己血条"] = {
["enabled"] = false,
},
["无BUFF血条"] = {
["enabled"] = false,
},
["目标血条"] = {
["enabled"] = false,
},
["精简血条"] = {
["enabled"] = false,
},
["宠物血条"] = {
["enabled"] = false,
},
},
["global"] = {
["enabled"] = false,
},
},
},
},
["Aura"] = {
["profiles"] = {
["Default"] = {
["layouts"] = {
["队伍的目标"] = {
["max_debuffs"] = 8,
["layout"] = {
["debuff"] = {
["my_size"] = 12,
["size"] = 10,
},
["buff"] = {
["my_size"] = 12,
["size"] = 8,
},
},
["max_buffs"] = 8,
["enabled"] = false,
},
["目标血条"] = {
["max_debuffs"] = 12,
["max_buffs"] = 12,
["layout"] = {
["buff"] = {
["my_size"] = 24,
["offset_y"] = -30,
["anchor"] = "BOTTOMRIGHT",
["size"] = 20,
["side"] = "RIGHT",
["growth"] = "left_down",
["offset_x"] = -30,
},
["debuff"] = {
["my_size"] = 24,
["anchor"] = "BOTTOMLEFT",
["size"] = 20,
["growth"] = "right_down",
},
},
},
["玩家自己血条"] = {
["max_debuffs"] = 8,
["enabled_buffs"] = false,
["max_buffs"] = 12,
["layout"] = {
["buff"] = {
["my_size"] = 12,
["size"] = 12,
},
["debuff"] = {
["size"] = 12,
},
},
},
["无BUFF血条"] = {
["max_debuffs"] = 8,
["layout"] = {
["buff"] = {
["my_size"] = 14,
["size"] = 14,
},
},
["max_buffs"] = 12,
["enabled"] = false,
},
["精简血条"] = {
["max_debuffs"] = 8,
["max_buffs"] = 8,
["layout"] = {
["buff"] = {
["my_size"] = 12,
["size"] = 8,
},
["debuff"] = {
["my_size"] = 12,
["size"] = 10,
},
},
},
["宠物血条"] = {
["max_debuffs"] = 8,
["max_buffs"] = 12,
["layout"] = {
["buff"] = {
["my_size"] = 14,
["size"] = 14,
},
},
},
},
},
["Hunter"] = {
["layouts"] = {
["队伍的目标"] = {
["layout"] = {
["debuff"] = {
["my_size"] = 12,
["size"] = 10,
},
["buff"] = {
["my_size"] = 12,
["size"] = 8,
},
},
["max_debuffs"] = 8,
["max_buffs"] = 8,
},
["玩家自己血条"] = {
["enabled_buffs"] = false,
["layout"] = {
["buff"] = {
["my_size"] = 12,
["size"] = 12,
},
["debuff"] = {
["size"] = 12,
},
},
["max_debuffs"] = 8,
["max_buffs"] = 12,
},
["无BUFF血条"] = {
["enabled"] = false,
["layout"] = {
["buff"] = {
["my_size"] = 14,
["size"] = 14,
},
},
["max_debuffs"] = 8,
["max_buffs"] = 12,
},
["目标血条"] = {
["layout"] = {
["buff"] = {
["my_size"] = 24,
["size"] = 20,
},
["debuff"] = {
["my_size"] = 24,
["size"] = 18,
},
},
["max_debuffs"] = 12,
["max_buffs"] = 12,
},
["精简血条"] = {
["layout"] = {
["buff"] = {
["my_size"] = 12,
["size"] = 8,
},
["debuff"] = {
["my_size"] = 12,
["size"] = 10,
},
},
["max_debuffs"] = 8,
["max_buffs"] = 8,
},
["宠物血条"] = {
["layout"] = {
["buff"] = {
["my_size"] = 14,
["size"] = 14,
},
},
["max_debuffs"] = 8,
["max_buffs"] = 12,
},
},
},
},
},
["Background"] = {
["profiles"] = {
["Default"] = {
["layouts"] = {
["无BUFF血条"] = {
["enabled"] = false,
},
},
},
["Hunter"] = {
["layouts"] = {
["无BUFF血条"] = {
["enabled"] = false,
},
},
},
},
},
["PowerBar"] = {
["profiles"] = {
["Default"] = {
["layouts"] = {
["队伍的目标"] = {
["size"] = 1,
["texture"] = "Clean",
},
["玩家自己血条"] = {
["size"] = 7,
["texture"] = "BantoBar",
},
["无BUFF血条"] = {
["size"] = 4,
["texture"] = "Clean",
},
["宠物血条"] = {
["size"] = 4,
["texture"] = "BantoBar",
},
["精简血条"] = {
["size"] = 4,
["texture"] = "Clean",
},
["目标血条"] = {
["size"] = 8,
["texture"] = "AlwaysWork",
},
},
},
["Hunter"] = {
["layouts"] = {
["队伍的目标"] = {
["size"] = 4,
["texture"] = "Clean",
},
["玩家自己血条"] = {
["size"] = 7,
["texture"] = "BantoBar",
},
["无BUFF血条"] = {
["size"] = 4,
["texture"] = "Clean",
},
["精简血条"] = {
["size"] = 4,
["texture"] = "Clean",
},
["目标血条"] = {
["size"] = 8,
["texture"] = "AlwaysWork",
},
["宠物血条"] = {
["size"] = 4,
["texture"] = "BantoBar",
},
},
},
},
},
["HideBlizzard"] = {
["profiles"] = {
["Default"] = {
["global"] = {
["castbar"] = false,
},
},
["Hunter"] = {
["global"] = {
["castbar"] = false,
},
},
},
},
["RestIcon"] = {
["profiles"] = {
["Default"] = {
["layouts"] = {
["玩家自己血条"] = {
["position"] = 1.00003,
["location"] = "edge_bottom_right",
["size"] = 1.4,
},
["无BUFF血条"] = {
["enabled"] = false,
},
["宠物血条"] = {
["enabled"] = false,
},
["标准"] = {
["position"] = 1.00003,
["location"] = "edge_bottom_right",
},
},
},
["Hunter"] = {
["layouts"] = {
["无BUFF血条"] = {
["enabled"] = false,
},
["宠物血条"] = {
["enabled"] = false,
},
},
},
},
},
["CombatIcon"] = {
["profiles"] = {
["Default"] = {
["layouts"] = {
["队伍的目标"] = {
["position"] = 1.00001,
},
["宠物血条"] = {
["enabled"] = false,
["position"] = 1.00001,
},
["玩家自己血条"] = {
["position"] = 1.00001,
},
["无BUFF血条"] = {
["enabled"] = false,
["position"] = 1.00001,
},
["精简血条"] = {
["position"] = 1.00001,
},
["目标血条"] = {
["position"] = 1.00001,
},
["标准"] = {
["position"] = 1.00001,
},
},
},
["Hunter"] = {
["layouts"] = {
["队伍的目标"] = {
["position"] = 1.00001,
},
["玩家自己血条"] = {
["position"] = 1.00001,
},
["无BUFF血条"] = {
["enabled"] = false,
["position"] = 1.00001,
},
["精简血条"] = {
["position"] = 1.00001,
},
["目标血条"] = {
["position"] = 1.00001,
},
["宠物血条"] = {
["enabled"] = false,
["position"] = 1.00001,
},
},
},
},
},
["HealthBar"] = {
["profiles"] = {
["Default"] = {
["layouts"] = {
["队伍的目标"] = {
["size"] = 12,
},
["玩家自己血条"] = {
["texture"] = "Aluminium",
["size"] = 12,
},
["无BUFF血条"] = {
["texture"] = "Skyline",
["size"] = 12,
},
["宠物血条"] = {
["texture"] = "Skyline",
["size"] = 12,
},
["精简血条"] = {
["size"] = 12,
},
["目标血条"] = {
["texture"] = "Aluminium",
["size"] = 12,
},
},
},
["Hunter"] = {
["layouts"] = {
["队伍的目标"] = {
["size"] = 12,
},
["玩家自己血条"] = {
["size"] = 12,
},
["无BUFF血条"] = {
["texture"] = "Skyline",
["size"] = 12,
},
["精简血条"] = {
["size"] = 12,
},
["目标血条"] = {
["texture"] = "Blizzard Character Skills Bar",
["size"] = 12,
},
["宠物血条"] = {
["texture"] = "Skyline",
["size"] = 12,
},
},
},
},
},
["ManaSpark"] = {
["profiles"] = {
["Default"] = {
["layouts"] = {
["无BUFF血条"] = {
["enabled"] = false,
},
["宠物血条"] = {
["enabled"] = false,
},
},
},
["Hunter"] = {
["layouts"] = {
["无BUFF血条"] = {
["enabled"] = false,
},
["宠物血条"] = {
["enabled"] = false,
},
},
},
},
},
["VisualHeal"] = {
["profiles"] = {
["Default"] = {
},
["Hunter"] = {
},
},
},
["LeaderIcon"] = {
["profiles"] = {
["Default"] = {
["layouts"] = {
["无BUFF血条"] = {
["enabled"] = false,
},
["宠物血条"] = {
["enabled"] = false,
},
},
},
["Hunter"] = {
["layouts"] = {
["无BUFF血条"] = {
["enabled"] = false,
},
["宠物血条"] = {
["enabled"] = false,
},
},
},
},
},
["Border"] = {
["profiles"] = {
["Default"] = {
["layouts"] = {
["玩家自己血条"] = {
["enabled"] = false,
["normal_texture"] = "Blizzard Dialog",
["padding"] = 5,
},
["无BUFF血条"] = {
["normal_texture"] = "Blizzard Dialog",
["padding"] = 1,
["size"] = 8,
},
["目标血条"] = {
["enabled"] = false,
["normal_texture"] = "Blizzard Dialog",
["padding"] = 5,
},
["宠物血条"] = {
["enabled"] = false,
["normal_texture"] = "Blizzard Dialog",
["padding"] = 4,
},
},
},
["Hunter"] = {
["layouts"] = {
["无BUFF血条"] = {
["normal_texture"] = "Blizzard Dialog",
["padding"] = 1,
["size"] = 8,
},
["目标血条"] = {
["enabled"] = false,
["normal_texture"] = "Blizzard Dialog",
["padding"] = 5,
},
["宠物血条"] = {
["enabled"] = false,
["normal_texture"] = "Blizzard Dialog",
["padding"] = 4,
},
["玩家自己血条"] = {
["enabled"] = false,
["normal_texture"] = "Blizzard Dialog",
["padding"] = 5,
},
},
},
},
},
["BlankSpace"] = {
["profiles"] = {
["Default"] = {
["layouts"] = {
["队伍的目标"] = {
["first"] = false,
["elements"] = {
["默认"] = {
["exists"] = true,
},
},
},
["宠物血条"] = {
["first"] = false,
["elements"] = {
["默认"] = {
["exists"] = true,
},
},
},
["玩家自己血条"] = {
["first"] = false,
["elements"] = {
["默认"] = {
["exists"] = true,
},
},
},
["无BUFF血条"] = {
["first"] = false,
["elements"] = {
["默认"] = {
["exists"] = true,
},
},
},
["精简血条"] = {
["first"] = false,
["elements"] = {
["默认"] = {
["exists"] = true,
},
},
},
["普通"] = {
["first"] = false,
["elements"] = {
["默认"] = {
["exists"] = true,
},
},
},
["目标血条"] = {
["first"] = false,
["elements"] = {
["默认"] = {
["exists"] = true,
},
},
},
},
},
["Hunter"] = {
["layouts"] = {
["队伍的目标"] = {
["elements"] = {
["默认"] = {
["exists"] = true,
},
},
["first"] = false,
},
["精简血条"] = {
["elements"] = {
["默认"] = {
["exists"] = true,
},
},
["first"] = false,
},
["玩家自己血条"] = {
["elements"] = {
["默认"] = {
["exists"] = true,
},
},
["first"] = false,
},
["无BUFF血条"] = {
["elements"] = {
["默认"] = {
["exists"] = true,
},
},
["first"] = false,
},
["目标血条"] = {
["elements"] = {
["默认"] = {
["exists"] = true,
},
},
["first"] = false,
},
["普通"] = {
["elements"] = {
["默认"] = {
["exists"] = true,
},
},
["first"] = false,
},
["宠物血条"] = {
["elements"] = {
["默认"] = {
["exists"] = true,
},
},
["first"] = false,
},
},
},
},
},
["ThreatBar"] = {
["profiles"] = {
["Default"] = {
["layouts"] = {
["队伍的目标"] = {
["enabled"] = false,
},
["玩家自己血条"] = {
["enabled"] = false,
},
["无BUFF血条"] = {
["enabled"] = false,
},
["目标血条"] = {
["enabled"] = false,
},
["精简血条"] = {
["enabled"] = false,
},
["宠物血条"] = {
["enabled"] = false,
},
},
["global"] = {
["enabled"] = false,
},
},
["Hunter"] = {
["layouts"] = {
["队伍的目标"] = {
["enabled"] = false,
},
["玩家自己血条"] = {
["enabled"] = false,
},
["无BUFF血条"] = {
["enabled"] = false,
},
["目标血条"] = {
["enabled"] = false,
},
["精简血条"] = {
["enabled"] = false,
},
["宠物血条"] = {
["enabled"] = false,
},
},
["global"] = {
["enabled"] = false,
},
},
},
},
["ReputationBar"] = {
["profiles"] = {
["Default"] = {
["layouts"] = {
["队伍的目标"] = {
["enabled"] = false,
},
["玩家自己血条"] = {
["enabled"] = false,
},
["无BUFF血条"] = {
["enabled"] = false,
},
["目标血条"] = {
["enabled"] = false,
},
["精简血条"] = {
["enabled"] = false,
},
["宠物血条"] = {
["enabled"] = false,
},
},
["global"] = {
["enabled"] = false,
},
},
["Hunter"] = {
["layouts"] = {
["队伍的目标"] = {
["enabled"] = false,
},
["玩家自己血条"] = {
["enabled"] = false,
},
["无BUFF血条"] = {
["enabled"] = false,
},
["目标血条"] = {
["enabled"] = false,
},
["精简血条"] = {
["enabled"] = false,
},
["宠物血条"] = {
["enabled"] = false,
},
},
["global"] = {
["enabled"] = false,
},
},
},
},
["Runes"] = {
["profiles"] = {
["Default"] = {
},
["Hunter"] = {
},
},
},
["PvPIcon"] = {
["profiles"] = {
["Default"] = {
["layouts"] = {
["玩家自己血条"] = {
["position"] = 1.00001,
["size"] = 1.65,
},
["无BUFF血条"] = {
["enabled"] = false,
},
["宠物血条"] = {
["enabled"] = false,
["position"] = 1.00001,
},
["标准"] = {
["position"] = 1.00001,
},
},
},
["Hunter"] = {
["layouts"] = {
["无BUFF血条"] = {
["enabled"] = false,
},
["宠物血条"] = {
["enabled"] = false,
["position"] = 1.00001,
},
},
},
},
},
},
["profileKeys"] = {},
["global"] = {
["config_version"] = 9,
},
["profiles"] = {
["Default"] = {
["class_order"] = {
"WARRIOR",
"PALADIN",
"PRIEST",
"SHAMAN",
"DRUID",
"ROGUE",
"MAGE",
"WARLOCK",
"HUNTER",
},
["layouts"] = {
["目标血条"] = {
["bar_spacing"] = 0,
["size_x"] = 230,
["size_y"] = 50,
["exists"] = true,
["bar_padding"] = 1,
["bar_texture"] = "Healbot",
},
["队伍的目标"] = {
["size_y"] = 20,
["exists"] = true,
["size_x"] = 85,
["bar_texture"] = "Healbot",
},
["宠物血条"] = {
["indicator_bar_outside_margin"] = 2,
["size_y"] = 35,
["exists"] = true,
["size_x"] = 120,
["bar_texture"] = "Healbot",
},
["玩家自己血条"] = {
["bar_spacing"] = 0,
["size_x"] = 230,
["size_y"] = 50,
["exists"] = true,
["bar_padding"] = 1,
["bar_texture"] = "Blizzard Character Skills Bar",
},
["无BUFF血条"] = {
["indicator_bar_outside_margin"] = 2,
["size_y"] = 30,
["exists"] = true,
["size_x"] = 100,
["bar_texture"] = "Healbot",
},
["精简血条"] = {
["size_y"] = 30,
["exists"] = true,
["size_x"] = 130,
["bar_texture"] = "Healbot",
},
["普通"] = {
["exists"] = true,
},
},
["made_groups"] = true,
["units"] = {
["玩家宠物的目标"] = {
["horizontal_mirror"] = true,
["unit"] = "pettarget",
["relative_point"] = "BOTTOM",
["anchor"] = "TOP",
["enabled"] = true,
["size_x"] = 0.8,
["size_y"] = 0.8,
["position_y"] = 70,
["position_x"] = -20,
["layout"] = "无BUFF血条",
["relative_to"] = "S玩家宠物",
},
["目标的目标"] = {
["relative_to"] = "S目标",
["unit"] = "targettarget",
["relative_point"] = "BOTTOMLEFT",
["anchor"] = "BOTTOMRIGHT",
["enabled"] = true,
["position_x"] = 367.7415161132813,
["position_y"] = -27.42169189453125,
["layout"] = "无BUFF血条",
},
["目标"] = {
["position_x"] = 266.3215942382813,
["unit"] = "target",
["relative_point"] = "TOPLEFT",
["anchor"] = "TOPLEFT",
["enabled"] = true,
["relative_to"] = "S玩家",
["position_y"] = -0.0833740234375,
["layout"] = "目标血条",
},
["玩家"] = {
["unit"] = "player",
["relative_point"] = "TOPLEFT",
["anchor"] = "TOPLEFT",
["enabled"] = true,
["position_x"] = 520.3960571289062,
["position_y"] = -79.773681640625,
["layout"] = "玩家自己血条",
},
["焦点的目标"] = {
["relative_to"] = "S焦点",
["unit"] = "focustarget",
["relative_point"] = "TOPRIGHT",
["anchor"] = "TOP",
["enabled"] = true,
["size_x"] = 1.2,
["size_y"] = 1.3,
["position_y"] = 51.47198486328125,
["position_x"] = -35.23907470703125,
["layout"] = "无BUFF血条",
},
["玩家宠物"] = {
["position_x"] = -30.43167114257813,
["unit"] = "pet",
["relative_point"] = "BOTTOMLEFT",
["anchor"] = "BOTTOMRIGHT",
["enabled"] = true,
["relative_to"] = "S玩家",
["position_y"] = -24.9951171875,
["layout"] = "宠物血条",
},
["焦点"] = {
["unit"] = "focus",
["relative_point"] = "TOPLEFT",
["anchor"] = "TOPLEFT",
["enabled"] = true,
["size_x"] = 0.8,
["size_y"] = 0.7,
["position_y"] = -548.9403686523438,
["position_x"] = 30.46363639831543,
["layout"] = "目标血条",
},
},
["made_units"] = true,
["groups"] = {
["小队的目标"] = {
["vertical_spacing"] = 60,
["position_x"] = 6,
["relative_point"] = "TOPRIGHT",
["units_per_column"] = 10,
["relative_to"] = "g队伍",
["enabled"] = true,
["layout"] = "队伍的目标",
["unit_group"] = "partytarget",
["exists"] = true,
["position_y"] = -10.4429931640625,
["include_player"] = true,
["show_when"] = {
["raid10"] = true,
["raid40"] = true,
["raid20"] = true,
["raid25"] = true,
["raid"] = true,
["raid30"] = true,
["raid15"] = true,
},
},
["队伍宠物"] = {
["unit_group"] = "partypet",
["exists"] = true,
},
["队伍"] = {
["vertical_spacing"] = 50,
["relative_point"] = "TOPLEFT",
["units_per_column"] = 10,
["enabled"] = true,
["layout"] = "精简血条",
["include_player"] = true,
["exists"] = true,
["position_y"] = -47.580078125,
["position_x"] = 61.96689987182617,
["show_when"] = {
["raid10"] = true,
["raid40"] = true,
["raid20"] = true,
["raid25"] = true,
["raid"] = true,
["raid30"] = true,
["raid15"] = true,
},
},
},
},
["Hunter"] = {
["groups"] = {
["小队的目标"] = {
["vertical_spacing"] = 50,
["position_x"] = 3.487251281738281,
["layout"] = "队伍的目标",
["unit_group"] = "partytarget",
["relative_to"] = "g队伍",
["enabled"] = true,
["relative_point"] = "TOPRIGHT",
["units_per_column"] = 10,
["exists"] = true,
["position_y"] = -10.4429931640625,
["include_player"] = true,
["show_when"] = {
["raid10"] = true,
["raid40"] = true,
["raid20"] = true,
["raid25"] = true,
["raid"] = true,
["raid30"] = true,
["raid15"] = true,
},
},
["队伍宠物"] = {
["exists"] = true,
["unit_group"] = "partypet",
},
["队伍"] = {
["vertical_spacing"] = 50,
["position_x"] = 19.00669670104981,
["layout"] = "精简血条",
["include_player"] = true,
["relative_point"] = "TOPLEFT",
["units_per_column"] = 10,
["enabled"] = true,
["exists"] = true,
["position_y"] = -96.9478759765625,
["show_when"] = {
["raid10"] = true,
["raid40"] = true,
["raid20"] = true,
["raid25"] = true,
["raid"] = true,
["raid30"] = true,
["raid15"] = true,
},
},
},
["class_order"] = {
"WARRIOR",
"PALADIN",
"PRIEST",
"SHAMAN",
"DRUID",
"ROGUE",
"MAGE",
"WARLOCK",
"HUNTER",
},
["layouts"] = {
["队伍的目标"] = {
["exists"] = true,
["size_y"] = 25,
["size_x"] = 130,
["bar_texture"] = "Healbot",
},
["宠物血条"] = {
["indicator_bar_outside_margin"] = 2,
["exists"] = true,
["size_y"] = 35,
["size_x"] = 120,
["bar_texture"] = "Healbot",
},
["玩家自己血条"] = {
["size_x"] = 230,
["bar_spacing"] = 0,
["exists"] = true,
["size_y"] = 50,
["bar_padding"] = 1,
["bar_texture"] = "Blizzard Character Skills Bar",
},
["无BUFF血条"] = {
["indicator_bar_outside_margin"] = 2,
["exists"] = true,
["size_y"] = 35,
["size_x"] = 110,
["bar_texture"] = "Healbot",
},
["精简血条"] = {
["exists"] = true,
["size_y"] = 30,
["size_x"] = 130,
["bar_texture"] = "Healbot",
},
["普通"] = {
["exists"] = true,
},
["目标血条"] = {
["size_x"] = 230,
["bar_spacing"] = 0,
["exists"] = true,
["size_y"] = 50,
["bar_padding"] = 1,
["bar_texture"] = "Healbot",
},
},
["made_groups"] = true,
["made_units"] = true,
["units"] = {
["玩家宠物的目标"] = {
["enabled"] = true,
["horizontal_mirror"] = true,
["size_y"] = 1.4,
["unit"] = "pettarget",
["relative_point"] = "BOTTOM",
["position_y"] = 65,
["anchor"] = "TOP",
["size_x"] = 1.2,
["relative_to"] = "S玩家宠物",
["layout"] = "无BUFF血条",
},
["目标的目标"] = {
["enabled"] = true,
["relative_to"] = "S目标",
["position_x"] = 367.7415161132813,
["position_y"] = -27.42169189453125,
["anchor"] = "BOTTOMRIGHT",
["layout"] = "无BUFF血条",
["relative_point"] = "BOTTOMLEFT",
["unit"] = "targettarget",
},
["目标"] = {
["enabled"] = true,
["position_x"] = 253.2938842773438,
["relative_to"] = "S玩家",
["position_y"] = 1.016845703125,
["anchor"] = "TOPLEFT",
["layout"] = "目标血条",
["relative_point"] = "TOPLEFT",
["unit"] = "target",
},
["玩家"] = {
["enabled"] = true,
["relative_point"] = "TOPLEFT",
["position_y"] = -73.04248046875,
["anchor"] = "TOPLEFT",
["layout"] = "玩家自己血条",
["position_x"] = 511.8926391601563,
["unit"] = "player",
},
["焦点的目标"] = {
["enabled"] = true,
["relative_to"] = "S焦点",
["size_y"] = 1.3,
["unit"] = "focustarget",
["relative_point"] = "TOPRIGHT",
["position_y"] = 51.47198486328125,
["anchor"] = "TOP",
["size_x"] = 1.2,
["position_x"] = -35.23907470703125,
["layout"] = "无BUFF血条",
},
["玩家宠物"] = {
["enabled"] = true,
["position_x"] = -30.43167114257813,
["relative_to"] = "S玩家",
["position_y"] = -24.9951171875,
["anchor"] = "BOTTOMRIGHT",
["layout"] = "宠物血条",
["relative_point"] = "BOTTOMLEFT",
["unit"] = "pet",
},
["焦点"] = {
["enabled"] = true,
["size_x"] = 0.8,
["size_y"] = 0.7,
["unit"] = "focus",
["relative_point"] = "TOPLEFT",
["position_y"] = -680.1079711914062,
["anchor"] = "TOPLEFT",
["position_x"] = 47.17075729370117,
["layout"] = "目标血条",
},
},
},
},
}

local locale = GetLocale and GetLocale() or "enUS"
local is_zh = (locale == "zhCN" or locale == "zhTW")

local map_en = {
	-- Layouts
	["玩家自己血条"] = "Player Bar",
	["目标血条"] = "Target Bar",
	["宠物血条"] = "Pet Bar",
	["无BUFF血条"] = "Party & No-Buff Bar",
	["精简血条"] = "Target / Compact Bar",
	-- Units & Groups
	["玩家"] = "Player",
	["玩家宠物"] = "Player's Pet",
	["玩家宠物的目标"] = "Pet Target",
	["目标"] = "Target",
	["目标的目标"] = "Target of Target",
	["焦点"] = "Focus",
	["焦点的目标"] = "Focus Target",
	["队伍"] = "Party",
	["小队的目标"] = "Party Targets",
	-- relative_to anchors
	["S玩家"] = "SPlayer",
	["S玩家宠物"] = "SPlayer's Pet",
	["S目标"] = "STarget",
	["S焦点"] = "SFocus",
	["g队伍"] = "gParty",
	-- LuaTexts
	["Lua:名称"] = "Lua:Name",
	["Lua:生命值"] = "Lua:Health",
	["Lua:能量"] = "Lua:Power",
	["Lua:职业"] = "Lua:Class",
	["Lua:PvP 计时器"] = "Lua:PvP Timer",
	["Lua:经验"] = "Lua:Experience",
	["Lua:法术"] = "Lua:Spell",
}

local function translate_db(tbl, map)
	if type(tbl) ~= "table" then return end
	local moves = {}
	for k, v in pairs(tbl) do
		if type(v) == "table" then
			translate_db(v, map)
		elseif type(v) == "string" and (k == "layout" or k == "relative_to") and map[v] then
			tbl[k] = map[v]
		end
		if type(k) == "string" and map[k] then
			moves[k] = map[k]
		end
	end
	for old_k, new_k in pairs(moves) do
		tbl[new_k] = tbl[old_k]
		tbl[old_k] = nil
	end
end

if not is_zh then
	translate_db(PitBull4DB, map_en)
end

end
