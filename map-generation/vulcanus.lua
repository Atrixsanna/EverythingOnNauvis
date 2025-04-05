local util = require("data-util")

return function(terrain)
    local vulcanus = {
        import_to_nauvis = function()
            data.raw.planet["nauvis"].map_gen_settings.autoplace_controls["vulcanus_volcanism"] = {}
            data.raw.planet["nauvis"].map_gen_settings.territory_settings = data.raw.planet["vulcanus"].map_gen_settings
                .territory_settings
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.tile.settings["volcanic-folds"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.tile.settings["volcanic-folds-flat"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.tile.settings["lava"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.tile.settings["lava-hot"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.decorative.settings["vulcanus-rock-decal-large"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.decorative.settings["vulcanus-crack-decal"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.decorative.settings["vulcanus-crack-decal-large"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.decorative.settings["vulcanus-crack-decal-huge-warm"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.decorative.settings["vulcanus-crack-decal-warm"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.decorative.settings["calcite-stain"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.decorative.settings["calcite-stain-small"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.decorative.settings["sulfur-stain"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.decorative.settings["sulfur-stain-small"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.decorative.settings["sulfuric-acid-puddle"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.decorative.settings["sulfuric-acid-puddle-small"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.decorative.settings["crater-small"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.decorative.settings["crater-large"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.decorative.settings["pumice-relief-decal"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.decorative.settings["vulcanus-sand-decal"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.decorative.settings["vulcanus-dune-decal"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.decorative.settings["waves-decal"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.decorative.settings["medium-volcanic-rock"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.decorative.settings["small-volcanic-rock"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.decorative.settings["tiny-volcanic-rock"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.decorative.settings["tiny-rock-cluster"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.decorative.settings["small-sulfur-rock"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.decorative.settings["tiny-sulfur-rock"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.decorative.settings["sulfur-rock-cluster"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.decorative.settings["vulcanus-lava-fire"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.entity.settings["crater-cliff"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.entity.settings["vulcanus-chimney"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.entity.settings["vulcanus-chimney-faded"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.entity.settings["vulcanus-chimney-cold"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.entity.settings["vulcanus-chimney-short"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.entity.settings["vulcanus-chimney-truncated"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.entity.settings["huge-volcanic-rock"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.entity.settings["big-volcanic-rock"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.entity.settings["sulfuric-acid-geyser"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.entity.settings["calcite"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.entity.settings["sulfuric-acid-geyser"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.entity.settings["tungsten-ore"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.entity.settings["scrap"] = {}
            data.raw.planet["nauvis"].map_gen_settings.autoplace_controls["sulfuric_acid_geyser"] = {}

            --- When masking is applied, the probability expression for sulfuric-acid-geysers will be set to a mask of default_sulfuric_acid_geyser            
            data.raw["noise-expression"]["default_sulfuric_acid_geyser"].expression = "vulcanus_sulfuric_acid_geyser_probability"
            data.raw["resource"]["sulfuric-acid-geyser"].autoplace.richness_expression = "vulcanus_sulfuric_acid_geyser_richness" 
            
            data.raw["autoplace-control"]["vulcanus_volcanism"].order = "z-volcanism"
            data.raw["autoplace-control"]["vulcanus_volcanism"].localised_description = {
                "autoplace-control-names.vulcanus_volcanism_description" }
            data.raw["autoplace-control"]["vulcanus_volcanism"].category = "resource"
            data.raw["autoplace-control"]["sulfuric_acid_geyser"].order = "b-z"

            data.raw["noise-expression"]["vulcanus_starting_calcite"].expression = "-inf"
            data.raw["noise-expression"]["vulcanus_calcite_probability"].expression =
            "(control:calcite:size > 0) * (1000 * ((0.5 + vulcanus_calcite_region) * random_penalty_between(0.9, 1, 1) - 1))"

            data.raw["noise-expression"]["vulcanus_sulfuric_acid_geyser_probability"].expression =
            "(control:sulfuric_acid_geyser:size > 0) * (0.005 * ((vulcanus_sulfuric_acid_region_patchy > 0) + 2 * updated_volcanic_folds))"
            data.raw["noise-expression"]["vulcanus_starting_sulfur"].expression = "-inf"

            data.raw["noise-expression"]["vulcanus_tungsten_ore_probability"].expression =
            "(control:tungsten_ore:size > 0) * (1000 * ((0.7 + vulcanus_tungsten_ore_region) * random_penalty_between(0.9, 1, 1) - 1))"
            data.raw["noise-expression"]["vulcanus_starting_tungsten"].expression = "-inf"


            -- Increase radius for vulcane to start spawning
            data.raw["noise-expression"]["vulcanus_starting_area_radius"].expression = "new_starting_radius"
            -- Influences volcanic-folds-flat tile - distance and radius are increased to match mountain_volcano_spots, also removes remains of starter spot
            data.raw["noise-expression"]["vulcanus_ashlands_start"].expression =
            "4 * starting_spot_at_angle{ angle = vulcanus_ashlands_angle,\z
                                                                                              distance = 170 * vulcanus_starting_area_radius,\z
                                                                                              radius = 740 * vulcanus_starting_area_radius,\z
                                                                                              x_distortion = 0.1 * vulcanus_starting_area_radius * (vulcanus_wobble_x + vulcanus_wobble_large_x + vulcanus_wobble_huge_x),\z
                                                                                              y_distortion = 0.1 * vulcanus_starting_area_radius * (vulcanus_wobble_y + vulcanus_wobble_large_y + vulcanus_wobble_huge_y)}"
            -- Influences volcanic-folds-flat tile - distance and radius are increased to match mountain_volcano_spots, also removes remains of starter spot
            data.raw["noise-expression"]["vulcanus_basalts_start"].expression =
            "2 * starting_spot_at_angle{ angle = vulcanus_basalts_angle,\z
                                                                                             distance = 180 * vulcanus_starting_area_radius,\z
                                                                                             radius = 760 * vulcanus_starting_area_radius,\z
                                                                                             x_distortion = 0.1 * vulcanus_starting_area_radius * (vulcanus_wobble_x + vulcanus_wobble_large_x + vulcanus_wobble_huge_x),\z
                                                                                             y_distortion = 0.1 * vulcanus_starting_area_radius * (vulcanus_wobble_y + vulcanus_wobble_large_y + vulcanus_wobble_huge_y)}"
            -- Influences volcanic-folds-flat tile - distance and radius are increased to match mountain_volcano_spots, also removes remains of starter spot
            data.raw["noise-expression"]["vulcanus_mountains_start"].expression =
            "2 * starting_spot_at_angle{ angle = vulcanus_mountains_angle,\z
                                                                                               distance = 190 * vulcanus_starting_area_radius,\z
                                                                                               radius = 780 * vulcanus_starting_area_radius,\z
                                                                                               x_distortion = 0.05 * vulcanus_starting_area_radius * (vulcanus_wobble_x + vulcanus_wobble_large_x + vulcanus_wobble_huge_x),\z
                                                                                               y_distortion = 0.05 * vulcanus_starting_area_radius * (vulcanus_wobble_y + vulcanus_wobble_large_y + vulcanus_wobble_huge_y)}"
            -- Removes starter spot from vulcanus
            data.raw["noise-expression"]["mountain_volcano_spots"].expression = "raw_spots - starting_protector"
            --data.raw["noise-expression"]["mountain_volcano_spots"].local_expressions.density_multiplier = "5 / sqrt(control:vulcanus_volcanism:frequency)"
            data.raw["noise-expression"]["mountain_volcano_spots"].local_expressions.density_multiplier = "1"
            data.raw["noise-expression"]["mountain_volcano_spots"].local_expressions.raw_spots =
            "spot_noise{x = x + vulcanus_wobble_x/2 + vulcanus_wobble_large_x/12 + vulcanus_wobble_huge_x/80,\z
                                                                                             y = y + vulcanus_wobble_y/2 + vulcanus_wobble_large_y/12 + vulcanus_wobble_huge_y/80,\z
                                                                                             seed0 = map_seed,\z
                                                                                             seed1 = 1,\z
                                                                                             candidate_spot_count = 1,\z
                                                                                             suggested_minimum_candidate_point_spacing = 400,\z
                                                                                             skip_span = 2,\z
                                                                                             skip_offset = 1,\z
                                                                                             region_size = 600,\z
                                                                                             density_expression = volcano_area / volcanism_sq,\z
                                                                                             spot_quantity_expression = volcano_spot_radius * volcano_spot_radius,\z
                                                                                             spot_radius_expression = volcano_spot_radius,\z
                                                                                             hard_region_target_quantity = 0,\z
                                                                                             spot_favorability_expression = volcano_area,\z
                                                                                             basement_value = 0,\z
                                                                                             maximum_spot_basement_radius = volcano_spot_radius}"
            -- Make volcano spots much rarer, see region_size
            data.raw["noise-expression"]["mountain_volcano_spots"].local_expressions.volcano_spot_radius =
            "300 * volcanism * sqrt(1 + control:vulcanus_volcanism:size)"
            -- Removes all lava spots except vulkane
            data.raw["noise-expression"]["lava_mountains_range"].expression =
            "1100 * range_select_base(mountain_lava_spots, 0.3, 1, 1, 0, 1) - offset_vulcano"
            -- Removes all lava spots except vulkane
            data.raw["noise-expression"]["lava_hot_mountains_range"].expression =
            "1000 * range_select_base(mountain_lava_spots, 0.15, 0.35, 1, 0, 1) - offset_vulcano"
            -- Mask vulcanus decoratives
            data.raw["noise-expression"]["crater_cliff"].expression =
            "mask_allow_volcano(0.5 * (vulcanus_rock_noise + 0.5 * aux - 0.5 * moisture) * (1 - max(vulcanus_basalts_biome,vulcanus_ashlands_biome)) * place_every_n(21,21,0,0))"
        end,
        generate = function()
            data:extend({
                -- Noise expressions
                {
                    -- To remove the small random lava puddles
                    type = "noise-expression",
                    name = "offset_vulcano",
                    expression = "0.1"
                },
                {
                    -- Noise expression for ring around lava spots
                    type = "noise-expression",
                    name = "updated_volcanic_folds",
                    expression =
                    "10 * range_select_base(mountain_volcano_spots * 1.95 - 0.9, 0.16, 10, 1, 0, 1) - offset_vulcano" --  Creates ring around lava_hot_mountains_range
                },
                {
                    -- Noise expression for surroundings of updated_volcanic_folds
                    type = "noise-expression",
                    name = "updated_volcanic_folds_flat",
                    expression =
                    "10 * range_select_base(mountain_volcano_spots * 1.95 - 0.9, 0, 0.5, 1, 0, 1) - offset_vulcano" --  Creates ring around updated_volcanic_folds
                },
                {
                    -- Noise expression for vulcano spot and close surround as mask
                    type = "noise-expression",
                    name = "volcano_mask",
                    expression = "mask_prevent_fixed(max(updated_volcanic_folds, lava_mountains_range, lava_hot_mountains_range) > 0)"
                },
                {
                    -- Noise expression for all vulcanus terrain as mask
                    type = "noise-expression",
                    name = "vulcanus_mask",
                    expression = "mask_prevent_fixed(max(volcano_mask, updated_volcanic_folds_flat) > 0)"
                },
            })
        end
    }
    return vulcanus
end
