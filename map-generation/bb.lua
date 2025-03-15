data:extend({
  {
    type = "noise-expression",
    name = "elevation",
    intended_property = "elevation",
    expression = "elevation_nauvis + river + island",
    local_expressions = {
      river = "if(abs(y+1) < 22, -inf, 0)",
      island = "if(distance <= 9, inf, 0)",
    },
    localised_name = {"noise-expression.elevation_nauvis"}
  }
})
