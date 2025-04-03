
local data_util = require("data-util")


-- Fix tech tree

-- Add new technology for traveling to solar system edge
data:extend({
  {
    type = "technology",
    name = "solar-system-edge-discovery",
    icon = "__space-age__/graphics/icons/solar-system-edge.png",
    icon_size = 64,
    essential = true,
    effects =
    {
      {
        type = "unlock-space-location",
        space_location = "solar-system-edge",
        use_icon_overlay_constant = true
      },
      {
        type = "unlock-recipe",
        recipe = "ammoniacal-solution-separation",
      },
      {
        type = "unlock-recipe",
        recipe = "solid-fuel-from-ammonia"
      },
      {
        type = "unlock-recipe",
        recipe = "ammonia-rocket-fuel"
      },
      {
        type = "unlock-recipe",
        recipe = "ice-platform",
      },
      {
        type = "unlock-recipe",
        recipe = "lightning-rod",
      },
    },
    prerequisites = {"space-platform-thruster"},
    unit =
    {
      count = 500,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"space-science-pack", 1}
      },
      time = 60
    }
  },
})

-- Add prerequisite to promethium-science-pack
table.insert(data.raw.technology["promethium-science-pack"].prerequisites, "solar-system-edge-discovery")
data.raw.technology['promethium-science-pack'].unit.count_formula = nil
data.raw.technology['promethium-science-pack'].unit.count = 10

-- Useless technology
data_util.hide_prototype("technology", "rail-support-foundations")

-- Nauvis
data.raw.technology["uranium-ammo"].prerequisites = {"military-4", "uranium-processing"}
data.raw.technology["epic-quality"].prerequisites = {"quality-module", "space-science-pack"}
data.raw.technology["epic-quality"].unit = {
  count = 100,
  ingredients = {
    {"automation-science-pack", 1},
    {"logistic-science-pack", 1},
    {"chemical-science-pack", 1},
    {"space-science-pack", 1}
  },
  time = 60
}
data.raw.technology["legendary-quality"].prerequisites = {"epic-quality", "utility-science-pack"}
data.raw.technology["legendary-quality"].unit = {
  count = 250,
  ingredients = {
    {"automation-science-pack", 1},
    {"logistic-science-pack", 1},
    {"chemical-science-pack", 1},
    {"space-science-pack", 1},
    {"utility-science-pack", 1}
  },
  time = 60
}
data.raw.technology["kovarex-enrichment-process"].prerequisites = {"uranium-processing"}
data_util.remove_packs("kovarex-enrichment-process", {'space-science-pack'})

-- Gleba
data.raw.technology["landfill"].prerequisites = nil
data.raw.technology["landfill"].unit = nil
data.raw.technology["landfill"].research_trigger = {
  type = "mine-entity",
  entity = "stone"
}
data.raw.technology["steel-processing"].prerequisites = nil
data.raw.technology["steel-processing"].unit = nil
data.raw.technology["steel-processing"].research_trigger = {
  type = "craft-item",
  item = "iron-plate",
  count = 200
}
data.raw.technology["agriculture"].prerequisites = {"landfill", "steel-processing"}
data.raw.technology['heating-tower'].prerequisites = {"concrete"}
data.raw.technology['heating-tower'].research_trigger = nil
data.raw.technology['heating-tower'].unit = {
  count = 500,
  ingredients = {
    {"automation-science-pack", 1},
    {"logistic-science-pack", 1}
  },
  time = 30
}
data.raw.technology["carbon-fiber"].prerequisites = {"agricultural-science-pack", "chemical-science-pack"}
data_util.remove_packs("carbon-fiber", {"space-science-pack"})
data_util.remove_packs("toolbelt-equipment", {"space-science-pack"})
data.raw.technology["stack-inserter"].prerequisites = {"carbon-fiber", "production-science-pack", "bulk-inserter"}
data_util.remove_packs("stack-inserter", {"space-science-pack","utility-science-pack"})
data.raw.technology['stack-inserter'].unit.count = 100
data_util.remove_packs("transport-belt-capacity-1", {"space-science-pack","utility-science-pack"})
data.raw.technology['transport-belt-capacity-1'].unit.count = 200
data_util.remove_packs("transport-belt-capacity-2", {"space-science-pack","utility-science-pack"})
data.raw.technology['transport-belt-capacity-2'].unit.count = 300
data_util.remove_packs("rocket-turret", {"space-science-pack"})
data.raw.technology['captivity'].prerequisites = {"agricultural-science-pack","rocketry"}
data.raw.technology['captivity'].unit = {
  count = 150,
  ingredients = {
    {"automation-science-pack", 1},
    {"logistic-science-pack", 1},
    {"agricultural-science-pack", 1}
  },
  time = 10
}
data.raw.technology['biolab'].prerequisites = {"biter-egg-handling","kovarex-enrichment-process"}
data.raw.technology['biolab'].unit = {
  count = 200,
  ingredients = {
    {"automation-science-pack", 1},
    {"logistic-science-pack", 1},
    {"chemical-science-pack", 1},
    {"agricultural-science-pack", 1}
  },
  time = 30
}
data.raw.technology['overgrowth-soil'].prerequisites = {"biter-egg-handling"}
data.raw.technology['overgrowth-soil'].unit = {
  count = 75,
  ingredients = {
    {"automation-science-pack", 1},
    {"logistic-science-pack", 1},
    {"agricultural-science-pack", 1}
  },
  time = 5
}

-- Fulgora
data.raw.technology.recycling.prerequisites = {}
data.raw.technology.recycling.research_trigger = {
  type = "mine-entity",
  entity = "scrap"
}
data.raw.technology['holmium-processing'].prerequisites = {'recycling', 'oil-processing'}
data.raw.technology['electromagnetic-plant'].prerequisites = {'holmium-processing', 'advanced-oil-processing'}
data.raw.technology['tesla-weapons'].prerequisites = {"electromagnetic-science-pack", "military-4"}
data_util.remove_packs("tesla-weapons", {"space-science-pack"})

-- Vulcanus
data.raw.technology['calcite-processing'].prerequisites = {}
data.raw.technology['tungsten-carbide'].prerequisites = {}
data.raw.technology['big-mining-drill'].prerequisites = {'foundry', 'electric-mining-drill', 'electric-engine'}

-- Aquilo
data.raw.technology['lithium-processing'].prerequisites = {'holmium-processing'}
data.raw.technology['cryogenic-plant'].prerequisites = {'lithium-processing'}
data.raw.technology['quantum-processor'].prerequisites = {'cryogenic-plant', 'electromagnetic-plant', 'carbon-fiber','tungsten-carbide'}
data.raw.technology['railgun'].prerequisites = {"quantum-processor", "military-4"}
data.raw.technology['captive-biter-spawner'].prerequisites = {"biter-egg-handling","kovarex-enrichment-process"}
data_util.remove_packs("quantum-processor", {'cryogenic-science-pack', "utility-science-pack"})
data_util.remove_packs("railgun", {'space-science-pack', 'cryogenic-science-pack'})
data_util.remove_packs("captive-biter-spawner", {'space-science-pack', 'cryogenic-science-pack'})
data_util.remove_packs("fusion-reactor", {'cryogenic-science-pack'})
data_util.remove_packs("fusion-reactor-equipment", {'cryogenic-science-pack'})

-- mid and late game science cost reductions
data.raw.technology['tesla-weapons'].unit.count = 250
data.raw.technology['uranium-ammo'].unit.count = 50
data.raw.technology['kovarex-enrichment-process'].unit.count = 75
data.raw.technology['spidertron'].unit.count = 500
data.raw.technology['nuclear-power'].unit.count = 250
data.raw.technology['asteroid-reprocessing'].unit.count = 100
data.raw.technology['advanced-asteroid-processing'].unit.count = 200
data.raw.technology['rocket-turret'].unit.count = 200
data.raw.technology['low-density-structure'].unit.count = 75
data.raw.technology['processing-unit'].unit.count = 75
data.raw.technology['rocket-fuel'].unit.count = 75
data.raw.technology['rocket-silo'].unit.count = 225
data.raw.technology['captive-biter-spawner'].unit.count = 500
data.raw.technology['railgun'].unit.count = 300
data.raw.technology['quantum-processor'].unit.count = 200
data.raw.technology['fusion-reactor'].unit.count = 800
data.raw.technology['fusion-reactor-equipment'].unit.count = 200
data.raw.technology['quality-module'].unit.count = 50
data.raw.technology['quality-module-2'].unit.count = 200
data.raw.technology['quality-module-3'].unit.count = 300
data.raw.technology['speed-module-3'].unit.count = 300
data.raw.technology['carbon-fiber'].unit.count = 50
data.raw.technology['stack-inserter'].unit.count = 200
data.raw.technology['transport-belt-capacity-1'].unit.count = 250
data.raw.technology['transport-belt-capacity-2'].unit.count = 500
