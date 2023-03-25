---获取自定义GUI
---@param player LuaPlayer | nil
local function get(player)
	if not player then
		return nil
	end
	return player.gui.relative['linked-plan']
end

---获取或创建自定义GUI
---@param player LuaPlayer
local function must(player)
	local gui = player.gui.relative['linked-plan']
	if gui then
		return gui
	end
	gui = player.gui.relative.add({
		type = "flow",
		name = "linked-plan",
		anchor = {
			gui = defines.relative_gui_type.linked_container_gui,
			position = defines.relative_gui_position.top,
		},
	})
	gui.style.width = 1089
	gui.style.horizontal_align = "center"
	gui.style.bottom_padding = 10
	gui.add({
		type = "choose-elem-button",
		name = "linked-selector",
		tooltip = { "mod-name.linked-plan" },
		elem_type = "item",
		item = "linked-chest",
	})
	return gui
end

---更新GUI
---@param gui LuaGuiElement | nil
---@param entity LuaEntity | nil
local function update(gui, entity)
	if gui == nil or entity == nil then return end
	gui['linked-selector'].elem_value = LP.ids.name(entity.link_id)
end

---关闭GUI
---@param gui LuaGuiElement | nil
local function close(gui)
	if gui == nil then return end
	gui.destroy()
end

---获取玩家与选择器UI
---@param player uint
---@param ui LuaGuiElement | nil
local function ui(player, ui)
	if ui == nil or ui.name ~= 'linked-selector' then
		return nil, nil
	end
	return game.get_player(player), ui
end

---获取玩家与选择器UI
---@param player LuaPlayer
local function get_ui(player)
	return player.gui.relative['linked-selector']
end

---暴露接口
LP.gui = {
	get = get,
	must = must,
	update = update,
	close = close,
	ui = ui,
	get_ui = get_ui,
}
