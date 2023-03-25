---@alias IdMap { name: string, id: number }
---@alias IdsMap { last: number, ids: table<string, number>, names: table<number, string> }

---@type fun(): IdsMap
local get_map = nil

local function init()
	---@type IdsMap
	local ids_map = global.ids_map

	if not ids_map then
		ids_map = {
			last = 1,
			ids = {},
			names = {},
		}
		global.ids_map = ids_map
	end

	get_map = function () return ids_map end
	LP.ids.__init__()
	return ids_map
end

get_map = init

---暴露接口
LP.ids_store = function ()
	return get_map()
end
