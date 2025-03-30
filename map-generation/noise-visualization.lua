if not mods['noise-tools'] then
    return
end

local noise_debug = require '__noise-tools__/noise-debug'

noise_debug.remove_non_tile_autoplace()
noise_debug.hide_map_cliffs()
noise_debug.tiles_to_visualisation('visualisation', -1, 2, '3-band')

noise_debug.add_visualisation_target('updated_volcanic_folds', nil, 1)
noise_debug.add_visualisation_target('updated_volcanic_folds_flat', nil, 1)
noise_debug.add_visualisation_target('vulcano_coverage', nil, 1)

noise_debug.add_visualisation_target('vulcanus_calcite_region', nil, 1)
noise_debug.add_visualisation_target('vulcanus_calcite_probability', nil, 1)
noise_debug.add_visualisation_target('vulcanus_calcite_richness', nil, 1)

noise_debug.add_visualisation_target('vulcanus_sulfuric_acid_geyser_probability', nil, 1)
noise_debug.add_visualisation_target('vulcanus_tungsten_ore_probability', nil, 1)

noise_debug.add_visualisation_target('vulcanus_sulfuric_acid_region', nil, 1)
noise_debug.add_visualisation_target('vulcanus_tungsten_ore_region', nil, 1)
