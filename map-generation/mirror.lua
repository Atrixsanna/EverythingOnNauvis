data:extend({
  {
    type = "noise-expression",
    name = "abs_y",
    intended_property = "elevation",
    expression = "if(y>0, -y-1, y)"
  }
})

local function abs_y(expr)
  --print('pre-abs_y: '..expr)
  expr = expr:gsub(',y = y', ',y = abs_y')
  --print('post-abs_y: '..expr)
  return expr
end

function abs_y_expression(key1, key2)
  data.raw[key1][key2].expression = abs_y(data.raw[key1][key2].expression)
end
function abs_y_local_expression(key1, key2, key3)
  data.raw[key1][key2].local_expressions[key3] = abs_y(data.raw[key1][key2].local_expressions[key3])
end

data.raw["noise-expression"]["mountain_volcano_spots"].local_expressions.raw_spots = abs_y(data.raw["noise-expression"]["mountain_volcano_spots"].local_expressions.raw_spots)
-- data.raw["noise-function"]["vulcanus_detail_noise"].expression = abs_y(data.raw["noise-function"]["vulcanus_detail_noise"].expression)
--data.raw["noise-expression"]["demolisher_territory_expression"].expression = abs_y(data.raw["noise-expression"]["demolisher_territory_expression"].expression)
abs_y_expression("noise-function", "vulcanus_detail_noise")
abs_y_expression("noise-expression", "demolisher_territory_expression")

-- mirror elevation
-- data.raw["noise-expression"]["nauvis_hills"].expression = abs_y(data.raw["noise-expression"]["nauvis_hills"].expression)
-- data.raw["noise-expression"]["nauvis_macro"].expression = abs_y(data.raw["noise-expression"]["nauvis_macro"].expression)
-- data.raw["noise-expression"]["nauvis_detail"].expression = abs_y(data.raw["noise-expression"]["nauvis_detail"].expression)
-- data.raw["noise-expression"]["nauvis_persistance"].expression = abs_y(data.raw["noise-expression"]["nauvis_persistance"].expression)
-- data.raw["noise-expression"]["nauvis_hills_cliff_level"].expression = abs_y(data.raw["noise-expression"]["nauvis_hills_cliff_level"].expression)
-- data.raw["noise-expression"]["nauvis_hills_offset"].expression = abs_y(data.raw["noise-expression"]["nauvis_hills_offset"].expression)
-- data.raw["noise-expression"]["nauvis_hills_offset_raw_y"].expression = abs_y(data.raw["noise-expression"]["nauvis_hills_offset_raw_y"].expression)

-- BEGIN noise-programs.lua
abs_y_expression("noise-expression", "temperature_basic")
abs_y_expression("noise-expression", "moisture_noise")
abs_y_expression("noise-expression", "aux_noise")
-- make_0_12like_lakes
-- make_0_12like_lakes local_expressions
-- finish_elevation
-- elevation_nauvis_function local_expressions
-- elevation_lakes
-- elevation_island
-- cliffiness_basic
-- cliffiness_nauvis local_expressions
abs_y_expression("noise-expression", "nauvis_persistance")
abs_y_expression("noise-expression", "nauvis_detail")
-- forst_path_billows
-- tree_small_noise
abs_y_expression("noise-expression", "nauvis_bridge_billows")
abs_y_expression("noise-expression", "nauvis_hills_offset_raw_x")
abs_y_expression("noise-expression", "nauvis_hills_offset_raw_y")
abs_y_expression("noise-expression", "nauvis_hills")
abs_y_expression("noise-expression", "nauvis_hills_offset")
abs_y_expression("noise-expression", "nauvis_hills_cliff_level")
abs_y_expression("noise-expression", "nauvis_macro")
-- END noise-program.lua
-- BEGIN noise-functions.lua
abs_y_local_expression("noise-function", "resource_autoplace_all_patches", "blobs0")
abs_y_local_expression("noise-function", "resource_autoplace_all_patches", "starting_patches")
abs_y_local_expression("noise-function", "resource_autoplace_all_patches", "regular_patches")
-- END noise-functions.lua


abs_y_expression("noise-expression", "gleba_wobble_x")
abs_y_expression("noise-expression", "gleba_wobble_y")
abs_y_expression("noise-expression", "gleba_wobble_small_x")
abs_y_expression("noise-expression", "gleba_wobble_small_y")
