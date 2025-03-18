
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
  count = 5
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
data_util.remove_packs("stack-inserter", {"space-science-pack"})
data_util.remove_packs("rocket-turret", {"space-science-pack"})

-- Fulgora
data.raw.technology.recycling.prerequisites = {}
data.raw.technology.recycling.research_trigger = {
  type = "mine-entity",
  entity = "scrap"
}
data.raw.technology['holmium-processing'].prerequisites = {'recycling', 'oil-processing'}
data.raw.technology['electromagnetic-plant'].prerequisites = {'holmium-processing', 'advanced-oil-processing'}
data_util.remove_packs("tesla-weapons", {"utility-science-pack", "space-science-pack"})
-- remove mil4
data.raw.technology['tesla-weapons'].prerequisites = {"electromagnetic-science-pack"}

-- Useless technology
data_util.hide_prototype("technology", "rail-support-foundations")

-- Vulcanus
data.raw.technology['calcite-processing'].prerequisites = {}
data.raw.technology['tungsten-carbide'].prerequisites = {}
data.raw.technology['big-mining-drill'].prerequisites = {'foundry', 'electric-mining-drill', 'electric-engine'}

-- Aquilo
data.raw.technology['lithium-processing'].prerequisites = {'holmium-processing'}
data.raw.technology['cryogenic-plant'].prerequisites = {'lithium-processing'}
data.raw.technology['quantum-processor'].prerequisites = {'cryogenic-science-pack', 'electromagnetic-plant', 'carbon-fiber','tungsten-carbide'}
data_util.remove_packs("quantum-processor", {"utility-science-pack", "space-science-pack"})
data_util.remove_packs("railgun", {"utility-science-pack", "space-science-pack"})
