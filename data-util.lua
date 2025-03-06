local data_util = {}

function data_util.hide_prototype(type, name)
  if data.raw[type][name] then
	  data.raw[type][name].hidden = true
  end
end

function data_util.delete_prototype(type, name)
  if data.raw[type][name] then
	  data.raw[type][name] = nil
  end
end

function data_util.remove_packs(name, packs)
    local map = {}
    for _, pack in pairs(packs) do
        map[pack] = true
    end
    local ingredients = data.raw.technology[name].unit.ingredients
    for i = #ingredients, 1, -1 do
        if map[ingredients[i][1]] then
            table.remove(ingredients, i)
        end
    end
end

function data_util.generate_default_name(name)
  return "default_" .. string.gsub(name, "-", "_")
end

return data_util
