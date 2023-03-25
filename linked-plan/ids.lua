---@param name string
---@param id number
local function set(name, id)
	local ids_map = LP.ids_store()
	ids_map.ids[name] = id
	ids_map.names[id] = name
end

---初始化
local function init()
	set('linked-chest', 0)
end

---获取或添加Id
---@param name any
---@return uint
local function must(name)
	if name == nil or type(name) ~= 'string' then
		return 0
	end
	local ids_map = LP.ids_store()
	local id = ids_map.ids[name]
	if id == nil then
		id = ids_map.last
		ids_map.last = ids_map.last + 1
		set(name, id)
	end
	return id
end

---从名字获取Id
---@param id uint
---@return string | nil
local function id_to_name(id)
	return LP.ids_store().names[id]
end

---暴露接口
LP.ids = {
	id = must,
	name = id_to_name,

	__init__ = init,
}
