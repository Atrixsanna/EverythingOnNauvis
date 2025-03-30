local Parser = require("parser")
local config = require("config")

-- This transforms any noise expression in the game, replacing all usages of the variable "y" with "abs_y" (defined in mirror.lua)
local function transform_expression(name, expr)
    local success, result = pcall(function()
        local ast = Parser:new(expr)
        return ast:replaceAllYInstancesWithAbsY()
    end)
    if success then
        log(
            "Replacing noise DSL '" ..
            name .. "' with expression '" .. expr .. "' with absolute expression '" .. result ..
            "'.")
        return result
    end
    log("Failed to parse noise DSL '" .. name .. "': with expression '" .. expr .. "'.")
    return nil
end

-- This recursively transforms a noise function, all local expressions, and all local noise functions for said function
local function transform_noise_function(name, func)
    if func.expression and type(func.expression) == "string" then
        local transformed = transform_expression("function-" .. name, func.expression)
        if transformed then
            func.expression = transformed
        end
    end

    if func.local_expressions then
        for k, localexpr in pairs(func.local_expressions) do
            if type(localexpr) == "string" then
                local transformed = transform_expression("function-" .. name .. " (local)", localexpr)
                if transformed then
                    func.local_expressions[k] = transformed
                end
            end
        end
    end

    if func.local_functions then
        for k, nested in pairs(func.local_functions) do
            transform_noise_function(name .. "-subfn-" .. k, nested)
        end
    end
end

-- Mirror all noise functions in the game
for name, func in pairs(data.raw["noise-function"] or {}) do
    transform_noise_function(name, func)
end

-- Mirror all autoplace expressions in the game
for typename, prototypes in pairs(data.raw) do
    for name, proto in pairs(prototypes) do
        if type(proto.autoplace) == "table" then
            for key, expr in pairs(proto.autoplace) do
                if (key == "probability_expression" or key == "richness_expression") and name ~= "abs_y" and type(expr) ==
                    "string" then
                    local transformed = transform_expression("autoplace-" .. typename .. "-" .. key, expr)
                    if transformed then
                        proto.autoplace[key] = transformed
                    end
                end
            end

            if type(proto.autoplace.local_expressions) == "table" then
                for subkey, subexpr in pairs(proto.autoplace.local_expressions) do
                    if type(subexpr) == "string" then
                        local transformed = transform_expression("autoplace-" .. subkey .. " (local)", subexpr)
                        if transformed then
                            proto.autoplace.local_expressions[subkey] = transformed
                        end
                    end
                end
            end

            if type(proto.autoplace.local_functions) == "table" then
                for subkey, subfn in pairs(proto.autoplace.local_functions) do
                    transform_noise_function(typename .. "-autoplace-localfn-" .. subkey, subfn)
                end
            end
        end
    end
end

-- Mirror all noise expressions and their local expressions in the game
for name, proto in pairs(data.raw["noise-expression"]) do
    local expr = proto.expression
    if type(expr) == "string" and name ~= "abs_y" then
        local transformed = transform_expression(name, expr)
        if transformed then
            proto.expression = transformed
        end
    end
    if (proto.local_expressions) then
        for subkey, localexpr in pairs(proto.local_expressions) do
            if (type(localexpr) == "string") then
                local local_transformed = transform_expression(name .. "-local-" .. subkey, localexpr)
                if local_transformed then
                    proto.local_expressions[subkey] = local_transformed
                end
            end
        end
    end
end

-- In order to avoid probability_expressions from returning a value in the range (0, 1), which apparently
-- invokes some non-mirrored RNG, we "binarize" the probability_expressions to either 0 or 1 in an exactly-mirrorable
-- fashion. This helps greatly to prevent discrepancies between north and south rocks, trees, oil, and scrap (maybe more)
-- This is not perfect but is pretty close, much better than using real values (e.g 0.23661) and handing them off to
-- whatever RNG that autoplace is using.
-- Very high frequency is used (input_scale) to simulate a hash function
local function binarize(expr)
    local rand = math.random(1000)
    return "if(" ..
        expr ..
        " > abs(basis_noise{x = x, y = abs_y, input_scale = 11.11, seed0 = map_seed, seed1 = " .. rand .. "}), 1, 0)"
end

-- binarize all tree placement
for k, v in pairs(data.raw["tree"]) do
    local autoplace = v.autoplace
    if (autoplace) then
        autoplace.probability_expression = binarize(autoplace.probability_expression)
    end
end

-- binarize scrap placement and fix richness
local scrap_autoplace = data.raw["resource"]["scrap"].autoplace
if (scrap_autoplace) then
    scrap_autoplace.probability_expression = binarize(scrap_autoplace.probability_expression)
    scrap_autoplace.richness_expression =
        "control:scrap:richness * (" ..
        tostring(config.scrap_variance) ..
        " * basis_noise{x = x, y = abs_y, input_scale = 1/8, seed0 = map_seed, seed1=1} + " ..
        tostring(config.scrap_base_richness) .. ")"
end

-- Oil patches, like rocks, have a hard time mirroring by default.
-- I think this is because oil patches have a 2x2 placement and they end up colliding with other patches, and the
-- map generator places them in some order (maybe top to bottom, left to right) but this causes collisions when crossing
-- the y-axis, so in north you can imagine it places top to bottom left to right but when it reaches south it's actually placing
-- oil in a bottom to top left to right order. In order to remedy this, I'm making essentially a checkerboard where oil can be placed
-- which prevents collisions of this sort.
local oil_autoplace = data.raw["resource"]["crude-oil"].autoplace
if (oil_autoplace) then
    local default_crude = data.raw["noise-expression"]["default_crude_oil"]
    default_crude.expression = Parser:new(default_crude.expression):replaceRandomPenalty(tostring(config
    .crude_oil_penalty))
    oil_autoplace.probability_expression = binarize(oil_autoplace.probability_expression) .. " * checkboard_probability"
end

--- Binarize the eggrafts
local eggraft_autoplace = data.raw["unit-spawner"]["gleba-spawner-small"].autoplace
if (eggraft_autoplace) then
    eggraft_autoplace.probability_expression = binarize(eggraft_autoplace.probability_expression) ..
        " * checkboard_probability"
end


-- binarize all rock placement
local hugerock_autoplace = data.raw["simple-entity"]["huge-rock"].autoplace
if (hugerock_autoplace) then
    hugerock_autoplace.probability_expression = binarize(hugerock_autoplace.probability_expression)
end

local bigrock_autoplace = data.raw["simple-entity"]["big-rock"].autoplace
if (bigrock_autoplace) then
    bigrock_autoplace.probability_expression = binarize(bigrock_autoplace.probability_expression)
end

local bigsandrock_autoplace = data.raw["simple-entity"]["big-sand-rock"].autoplace
if (bigsandrock_autoplace) then
    bigsandrock_autoplace.probability_expression = binarize(bigsandrock_autoplace.probability_expression)
end
