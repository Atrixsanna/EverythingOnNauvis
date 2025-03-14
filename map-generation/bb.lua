data:extend({
  {
    type = "noise-expression",
    name = "elevation",
    intended_property = "elevation",
    expression = "if((abs(y+1) < 22) - (abs(x) < 10), -inf, elevation_nauvis)",
    localised_name = {"noise-expression.elevation_nauvis"}
  }
})
