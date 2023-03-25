---获取LinkedContainer实体
---@param entity LuaEntity | LuaItemStack | LuaEquipment | LuaEquipmentGrid | LuaPlayer | LuaGuiElement | LuaInventory | LuaTechnology | defines.gui_type | nil
---@return LuaEntity | nil
local function get(entity)
	if not entity or entity.prototype.type ~= 'linked-container' then return nil end
	return entity
end

---获取玩家与LinkedContainer实体
---@param player uint
---@param entity LuaEntity | nil
local function with(player, entity)
	if not entity or entity.prototype.type ~= 'linked-container' then
		return nil, nil
	end
	return game.get_player(player), entity
end

---更新玩家
---@param player LuaPlayer
local function update(player)
	local ui = LP.gui.get_ui(player)
	if not ui then return end
	local entity = get(player.opened)
	if not entity then return end
	ui.elem_value = LP.ids.name(entity.link_id)
end

---更新所有玩家
---@param player_index uint
local function update_all(player_index)
	for _, player in pairs(game.players) do
		if player.index ~= player_index then update(player) end
	end
end

---暴露接口
LP.entity = {
	get = get,
	with = with,
	update_all = update_all,
}
