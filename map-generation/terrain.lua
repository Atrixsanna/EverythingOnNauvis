--------------------------------------------------------------------------------
-- Fixes map generation for terrain
--------------------------------------------------------------------------------
local config = require("config")
local masks = require("masks")

local terrain = {}

local gleba = require("gleba")(terrain)
local aquilo = require("aquilo")(terrain)
local vulcanus = require("vulcanus")(terrain)

aquilo.import_to_nauvis()
vulcanus.import_to_nauvis()
gleba.import_to_nauvis()

masks.declare_masks()

aquilo.generate()
gleba.generate()
vulcanus.generate()

masks.apply_masks(terrain)

data:extend({
  {
    type = "noise-expression",
    name = "new_starting_radius",
    expression = config.new_starting_radius
  },
})


local mapgen = data.raw.planet.nauvis.map_gen_settings
local pen = mapgen.property_expression_names
local ac = mapgen.autoplace_controls

mapgen.cliff_settings = { cliff_elevation_interval = 0, cliff_elevation_0 = 0 }
pen['gleba_spawner'] = '0' -- only small egg rafts
pen['control:aquilo_crude_oil:size'] = tostring(config.aquilo_crude_oil_size)
pen['control:aquilo_crude_oil:frequency'] = tostring(config.aquilo_crude_oil_frequency)
pen['control:aquilo_crude_oil:richness'] = tostring(config.aquilo_crude_oil_richness)
ac['aquilo_crude_oil'] = {
  frequency = config.aquilo_crude_oil_frequency,
  size = config.aquilo_crude_oil_size,
  richness =
      config.aquilo_crude_oil_richness
}

pen['control:gleba_water:size'] = tostring(config.gleba_water_size)
pen['control:gleba_water:frequency'] = tostring(config.gleba_water_frequency)
pen['control:gleba_water:richness'] = tostring(config.gleba_water_richness)
ac['gleba_water'] = {
  frequency = config.gleba_water_frequency,
  size = config.gleba_water_size,
  richness = config
      .gleba_water_richness
}

pen['control:fluorine_vent:size'] = tostring(config.fluorine_vent_size)
pen['control:fluorine_vent:frequency'] = tostring(config.fluorine_vent_frequency)
pen['control:fluorine_vent:richness'] = tostring(config.fluorine_vent_richness)
ac['fluorine_vent'] = {
  frequency = config.fluorine_vent_frequency,
  size = config.fluorine_vent_size,
  richness = config
      .fluorine_vent_richness
}

pen['control:vulcanus_volcanism:size'] = tostring(config.vulcanus_volcanism_size)
pen['control:vulcanus_volcanism:frequency'] = tostring(config.vulcanus_volcanism_frequency)
pen['control:vulcanus_volcanism:richness'] = tostring(config.vulcanus_volcanism_richness)
ac["vulcanus_volcanism"] = {
  frequency = config.vulcanus_volcanism_frequency,
  size = config.vulcanus_volcanism_size,
  richness =
      config.vulcanus_volcanism_richness
}

pen['control:tungsten_ore:size'] = tostring(config.tungsten_ore_size)
pen['control:tungsten_ore:frequency'] = tostring(config.tungsten_ore_frequency)
pen['control:tungsten_ore:richness'] = tostring(config.tungsten_ore_richness)
ac['tungsten_ore'] = {
  frequency = config.tungsten_ore_frequency,
  size = config.tungsten_ore_size,
  richness = config
      .tungsten_ore_richness
}

pen['control:calcite:size'] = tostring(config.calcite_size)
pen['control:calcite:frequency'] = tostring(config.calcite_frequency)
pen['control:calcite:richness'] = tostring(config.calcite_richness)
ac['calcite'] = { frequency = config.calcite_frequency, size = config.calcite_size, richness = config.calcite_richness }

pen['control:sulfuric-acid_geyser:size'] = tostring(config.sulfuric_acid_geyser_size)
pen['control:sulfuric-acid_geyser:frequency'] = tostring(config.sulfuric_acid_geyser_frequency)
pen['control:sulfuric-acid_geyser:richness'] = tostring(config.sulfuric_acid_geyser_richness)
ac['sulfuric_acid_geyser'] = {
  frequency = config.sulfuric_acid_geyser_frequency,
  size = config
      .sulfuric_acid_geyser_size,
  richness = config.sulfuric_acid_geyser_richness
}

ac["coal"] = {
  frequency = config.coal_frequency,
  size = config.coal_size,
  richness = config.coal_richness,
}

ac["stone"] = {
  frequency = config.stone_frequency,
  size = config.stone_size,
  richness = config.stone_richness,
}

ac["copper-ore"] = {
  frequency = config.copper_ore_frequency,
  size = config.copper_ore_size,
  richness = config.copper_ore_richness,
}

ac["scrap"] = {
  frequency = config.scrap_frequency,
  size = config.scrap_size,
  richness = config.scrap_richness,
}

ac["iron-ore"] = {
  frequency = config.iron_ore_frequency,
  size = config.iron_ore_size,
  richness = config.iron_ore_richness,
}

ac["uranium-ore"] = {
  frequency = config.uranium_ore_frequency,
  size = config.uranium_ore_size,
  richness = config.uranium_ore_richness,
}

ac["crude-oil"] = {
  frequency = config.crude_oil_frequency,
  size = config.crude_oil_size,
  richness = config.crude_oil_richness,
}

ac["water"] = {
  frequency = config.water_frequency,
  size = config.water_size,
}

ac["trees"] = {
  frequency = config.trees_frequency,
  size = config.trees_size,
}

ac["ammonia_ocean"] = {
  frequency = config.ammonia_ocean_frequency,
  size = config.ammonia_ocean_size,
  richness = config.ammonia_ocean_richness,
}

local f = string.format
local NE = data.raw['noise-expression']

--- Richness
for _, ore in pairs({ 'iron-ore', 'copper-ore', 'coal', 'stone', 'scrap' }) do
  data.raw.resource[ore].autoplace.richness_expression = data.raw.resource[ore].autoplace.richness_expression ..
      ' * ((distance < ' .. config.distance_richness_threshold .. ') * 9 + 1)'
end

-- Moat
local moat_water = table.deepcopy(data.raw.tile.deepwater)

moat_water.name = 'moat'
moat_water.collision_mask = {
  layers = {
    doodad = true,
    item = true,
    player = true,
    rail = true,
    resource = true,
    water_tile = true,
  },
}
moat_water.autoplace = { probability_expression = 'moat * inf' }
moat_water.default_cover_tile = nil

data:extend({ moat_water })

--- Enemies
NE['enemy_base_probability'].expression =
'is_roughly_biter_area{ x = x, y = y } * (decorative_mix_noise{seed = map_seed_small, input_scale = 1/7} - 0.5)'


--- Mixed ores

--- Generates a series of basis_noises with decreasing amplitudes and increasing frequency
--- Used for brownian motion simulation, found in article here: https://iquilezles.org/articles/fbm/
--- Approximates the procedural mixed ore which is generated in BB scenario
--- @param stages any
--- @return string
local function brownian_motion(stages)
  local r = math.random(5000)
  local xp = ""
  for i = 1, stages, 1 do
    local freq = "1/" .. math.pow(2, 6 - i)
    local mult = "*" .. i
    local noise = "(basis_noise {x = x, y = abs_y, seed0 = map_seed, seed1 = " ..
        r .. ", input_scale = " .. freq .. "})" .. mult
    if (i == 1) then
      xp = noise
    else
      xp = xp .. " + " .. noise
    end
  end

  return xp
end

local mixed_noise = f(
  "multioctave_noise{x = x + %s, y = abs_y + %s, seed0 = map_seed, seed1 = 1234, persistence = 0.9, octaves = 3, input_scale = 1/51}",
  brownian_motion(3), brownian_motion(3))
local threshold = 1.15 -- higher = fewer, smaller mixed ore patches
local bound = {
  lower = 0,
  upper = 0,
}
local mgs = data.raw.planet.nauvis.map_gen_settings
local ores = {
  { name = 'iron-ore' },
  { name = 'coal' },
  { name = 'iron-ore' },
  { name = 'copper-ore' },
  { name = 'iron-ore' },
  { name = 'stone' },
  { name = 'copper-ore' },
  { name = 'iron-ore' },
  { name = 'copper-ore' },
  { name = 'iron-ore' },
  { name = 'coal' },
  { name = 'iron-ore' },
  { name = 'copper-ore' },
  { name = 'iron-ore' },
  { name = 'stone' },
  { name = 'copper-ore' },
  { name = 'coal' },
}
local ore_count = #ores

for i, ore in pairs(ores) do
  local mixed_ore_sample = table.deepcopy(data.raw.resource[ore.name])
  mixed_ore_sample.name = f('mixed-%d-%s', i, ore.name)
  mixed_ore_sample.localised_name = { 'entity-name.' .. ore.name }
  mixed_ore_sample.autoplace = {
    order = "c",
    probability_expression = '(distance > ' ..
        config.starting_radius ..
        ') * (ore > threshold) * (floor(((ore * 10) % ' .. (ore_count) .. ') + 1) == ' .. i .. ')',
    richness_expression = 'random_penalty{ x = x, y = abs_y, source = 10000, seed = map_seed, amplitude = 3000}',
    local_expressions = {
      ore = mixed_noise,
      threshold = threshold
    }
  }

  mixed_ore_sample.autoplace.probability_expression = "mask_allow_nauvis(" .. mixed_ore_sample.autoplace.probability_expression .. ")"
  data:extend({ mixed_ore_sample })
  mgs.autoplace_settings.entity.settings[mixed_ore_sample.name] = {}
  bound.lower = bound.upper
end

return terrain
