require 'linked-plan.linked-plan'

---当玩家打开GUI
---@param event { player_index: uint, gui_type: defines.gui_type, entity: LuaEntity? }
local function when_gui_opened(event)
	local player, entity = LP.entity.with(event.player_index, event.entity)
	if not player or not entity then return end
	LP.gui.update(LP.gui.must(player), event.entity)
end
script.on_event(defines.events.on_gui_opened, when_gui_opened)

---当玩家修改选择
---@param event { player_index: uint, element: LuaGuiElement }
local function when_gui_element_changed(event)
	local player, ui = LP.gui.ui(event.player_index, event.element)
	if not player or not ui then return end
	local entity = LP.entity.get(player.opened)
	if not entity then
		LP.gui.close(LP.gui.get(player))
		return
	end
	entity.link_id = LP.ids.id(ui.elem_value)
	LP.entity.update_all(player.index)
end
script.on_event(defines.events.on_gui_elem_changed, when_gui_element_changed)

---当玩家关闭GUI
---@param event { player_index: uint, gui_type: defines.gui_type, entity: LuaEntity? }
local function when_gui_closed(event)
	local player, entity = LP.entity.with(event.player_index, event.entity)
	if not player or not entity then return end
	LP.gui.close(LP.gui.get(player))
end
script.on_event(defines.events.on_gui_closed, when_gui_closed)
