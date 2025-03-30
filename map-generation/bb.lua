local config = require("config")
local f = string.format

data:extend({
  {
    type = "noise-expression",
    name = "elevation",
    intended_property = "elevation",
    expression = "elevation_nauvis + if(moat, -inf, 0)",
    localised_name = { "noise-expression.elevation_nauvis" }
  },
  {
    type = "noise-expression",
    name = "checkboard_probability",
    expression = "if(x % 4 >= 2, 0.5, -0.5) + if(abs_y % 4 >= 2, 0.5, -0.5)"
  },
  {
    type = "noise-expression",
    name = "abs_y",
    intended_property = "elevation",
    expression = "if(y>0, y, -y-1)"
  },
  {
    type = 'noise-expression',
    name = 'moat',
    expression = f('(abs_y < %d) + ((y*y) + (x*x) < 4*(%d^2)) - 2*((y*y + x*x) < (0.5 * %d^2))', config.starting_radius,
      -- expression = f('(abs_y < %d)', config.starting_radius,
      config.starting_radius, config.starting_radius),
  },
  {
    type = 'noise-function',
    name = 'is_roughly_biter_area',
    parameters = { "x", "y" },
    expression = 'abs_y >= ' .. config.biter_nest_distance .. ' + (abs(x) * 0.45) + (basis_noise{x=x, y=abs_y, seed0=map_seed, seed1=1234, input_scale = 1/8, output_scale = 20})',
  }
})

local x = 1
