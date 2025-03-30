local nauvis2 = table.deepcopy(data.raw.planet.nauvis)
nauvis2.name = "nauvis2"
data:extend{ nauvis2 }

require("prototypes.remove-planets")
