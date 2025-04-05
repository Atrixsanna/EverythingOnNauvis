if not mods['noise-tools'] then
    return
end

local noise_debug = require '__noise-tools__/noise-debug'

-- noise_debug.remove_non_tile_autoplace()
noise_debug.hide_map_cliffs()
noise_debug.tiles_to_visualisation('visualisation', -1, 2, '3-band')

noise_debug.add_visualisation_target('updated_volcanic_folds', nil, 1)
noise_debug.add_visualisation_target('updated_volcanic_folds_flat', nil, 1)
noise_debug.add_visualisation_target('vulcano_coverage', nil, 1)

noise_debug.add_visualisation_target('vulcanus_calcite_region', nil, 1)
noise_debug.add_visualisation_target('vulcanus_calcite_probability', nil, 1)
noise_debug.add_visualisation_target('vulcanus_calcite_richness', nil, 1)

noise_debug.add_visualisation_target("sulfuric_acid_probability_masked", data.raw["resource"]["sulfuric-acid-geyser"].autoplace.probability_expression,  1)
noise_debug.add_visualisation_target('vulcanus_sulfuric_acid_geyser_probability', nil, 1)
noise_debug.add_visualisation_target('vulcanus_sulfuric_acid_geyser_richness', nil, 1)
noise_debug.add_visualisation_target('vulcanus_tungsten_ore_probability', nil, 1)

noise_debug.add_visualisation_target('vulcanus_sulfuric_acid_region', nil, 1)
noise_debug.add_visualisation_target('vulcanus_tungsten_ore_region', nil, 1)

noise_debug.add_visualisation_target("gleba_mask", nil, 1)
noise_debug.add_visualisation_target("vulcanus_mask", nil, 1)
noise_debug.add_visualisation_target("volcano_mask", nil, 1)
noise_debug.add_visualisation_target("aquilo_mask", nil, 1)

noise_debug.add_visualisation_target("mask_prevent_fixed", "mask_prevent_fixed{expression=1}", 1)
noise_debug.add_visualisation_target("mask_prevent_biter", "mask_prevent_biter{expression=1}", 1)
noise_debug.add_visualisation_target("mask_allow_aquilo", "mask_allow_aquilo{expression=1}",  1)
noise_debug.add_visualisation_target("mask_prevent_aquilo", "mask_prevent_aquilo{expression=1}",  1)
noise_debug.add_visualisation_target("mask_allow_ammonia_ocean", "mask_allow_ammonia_ocean{expression=1}",  1)
noise_debug.add_visualisation_target("mask_prevent_ammonia_ocean", "mask_prevent_ammonia_ocean{expression=1}",  1)
noise_debug.add_visualisation_target("mask_allow_volcano", "mask_allow_volcano{expression=1}",  1)
noise_debug.add_visualisation_target("mask_prevent_volcano", "mask_prevent_volcano{expression=1}",  1)
noise_debug.add_visualisation_target("mask_allow_vulcanus", "mask_allow_vulcanus{expression=1}",  1)
noise_debug.add_visualisation_target("mask_prevent_vulcanus", "mask_prevent_vulcanus{expression=1}",  1)
noise_debug.add_visualisation_target("mask_allow_volcano", "mask_allow_volcano{expression=1}",  1)
noise_debug.add_visualisation_target("mask_prevent_volcano", "mask_prevent_volcano{expression=1}",  1)
noise_debug.add_visualisation_target("mask_allow_gleba", "mask_allow_gleba{expression=1}",  1)
noise_debug.add_visualisation_target("mask_prevent_gleba", "mask_prevent_gleba{expression=1}",  1)
noise_debug.add_visualisation_target("mask_allow_nauvis_and_moat", "mask_allow_nauvis_and_moat{expression=1}",  1)
noise_debug.add_visualisation_target("updated_water", nil,  1)
noise_debug.add_visualisation_target("updated_deepwater", nil,  1)