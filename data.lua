do
    cflib.add_composite_factory{
        name = "tar-0-a",
        ingredients = {},
        results = {
            {type = "fluid", name = "tar", amount = 250}
        },
        energy_required = 1.0,
        constituent_buildings = {
            {"transport-belt", 200},
            {"pipe-to-ground", 100},
            {"pipe", 50},
            {"small-electric-pole", 40},
            {"fast-inserter", 40},
            {"soil-extractormk01", 20},
            {"washer", 10},
            {"offshore-pump", 4},
            {"py-sinkhole", 1},
            {"distilator", 1}
        },
        size = 36,
        energy_usage = "10MW",
        emissions_per_minute = 1.68,
        unlocked_by = cflib.base_technology
    }

    cflib.add_composite_factory{
        name = "quartz-0-a",
        ingredients = {},
        results = {
            {"ore-quartz", 3}
        },
        energy_required = 1.0,
        constituent_buildings = {
            {"transport-belt", 200},
            {"underground-belt", 12},
            {"pipe-to-ground", 60},
            {"pipe", 60},
            {"small-electric-pole", 50},
            {"fast-inserter", 50},
            {"soil-extractormk01", 16},
            {"washer", 8},
            {"automated-screener-mk01", 8},
            {"offshore-pump", 4},
            {"py-sinkhole", 1}
        },
        size = 32,
        energy_usage = "10MW",
        emissions_per_minute = 1.35,
        unlocked_by = cflib.base_technology
    }

    cflib.add_composite_factory{
        name = "titanium-plate-0-a",
        ingredients = {},
        results = {
            {"titanium-plate", 1}
        },
        energy_required = 1.0,
        constituent_buildings = {
            {"transport-belt", 350},
            {"underground-belt", 10},
            {"splitter", 10},
            {"pipe-to-ground", 80},
            {"pipe", 70},
            {"small-electric-pole", 60},
            {"fast-inserter", 100},
            {"soil-extractormk01", 20},
            {"washer", 10},
            {"classifier", 11},
            {"automated-screener-mk01", 3},
            {"offshore-pump", 10},
            {"py-sinkhole", 1},
            {"jaw-crusher", 2},
            {"secondary-crusher-mk01", 1},
            {"ball-mill-mk01", 1},
            {"advanced-foundry-mk01", 1}
        },
        size = 42,
        energy_usage = "14MW",
        emissions_per_minute = 2.57,
        unlocked_by = cflib.base_technology
    }

    cflib.add_composite_generator{
        name = "electricity-1-a",
        energy_production = "90MW",
        buffer_capacity = "90MJ",
        constituent_buildings = {
            {"pipe-to-ground", 180},
            {"pipe", 125},
            {"steam-engine", 110},
            {"small-electric-pole", 75},
            {"oil-boiler-mk01", 55},
            {"fast-inserter", 12},
            {"transport-belt", 10},
            {"distilator", 7},
            {"py-sinkhole", 5},
            {"offshore-pump", 5},
            {"py-overflow-valve", 2},
            {"py-gas-vent", 2},
            {"soil-extractormk01", 2},
            {"fluid-separator", 2},
            {"electrolyzer-mk01", 1},
            {"lor-mk01", 1},
            {"washer", 1},
            {"quenching-tower", 1},
            {"advanced-foundry-mk01", 1}
        },
        size = 54,
        unlocked_by = cflib.base_technology
    }

    cflib.add_composite_generator{
        name = "electricity-1-b",
        energy_production = "90MW",
        buffer_capacity = "90MJ",
        constituent_buildings = {
            {"pipe-to-ground", 250},
            {"pipe", 250},
            {"transport-belt", 120},
            {"small-electric-pole", 75},
            {"fast-inserter", 30},
            {"plankton-farm", 10},
            {"power-house", 10},
            {"long-handed-inserter", 10},
            {"gasturbinemk01", 8},
            {"gasifier", 7},
            {"soil-extractormk01", 6},
            {"offshore-pump", 6},
            {"electrolyzer-mk01", 5},
            {"washer", 3},
            {"vacuum-pump-mk01", 2},
            {"storage-tank", 2},
            {"compost-plant-mk01", 1},
            {"py-underflow-valve", 1},
            {"py-overflow-valve", 1},
            {"py-sinkhole", 1},
            {"py-gas-vent", 1},
            {"distilator", 1}
        },
        size = 42,
        unlocked_by = cflib.base_technology
    }

    local circuit_2_tech =  cflib.add_technology{
        name = "circuit-2-technology",
        prerequisites = {"basic-electronics", cflib.base_technology},
        num_units = 500,
        unit_ingredients = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        unit_time = 60
    }

    cflib.add_composite_generator{
        name = "electricity-2-a",
        energy_production = "380MW",
        buffer_capacity = "380MJ",
        constituent_buildings = {
            {"pipe-to-ground", 270},
            {"pipe", 240},
            {"fast-transport-belt", 60},
            {"transport-belt", 60},
            {"small-electric-pole", 90},
            {"fast-inserter", 30},
            {"plankton-farm-mk02", 8},
            {"power-house-mk02", 10},
            {"long-handed-inserter", 10},
            {"gasturbinemk02", 14},
            {"gasifier-mk02", 7},
            {"soil-extractormk02", 6},
            {"offshore-pump", 9},
            {"electrolyzer-mk02", 5},
            {"washer-mk02", 3},
            {"vacuum-pump-mk02", 2},
            {"storage-tank", 2},
            {"compost-plant-mk02", 1},
            {"py-underflow-valve", 1},
            {"py-overflow-valve", 1},
            {"py-sinkhole", 1},
            {"py-gas-vent", 1},
            {"distilator-mk02", 1}
        },
        size = 50,
        unlocked_by = circuit_2_tech
    }

    cflib.add_composite_factory{
        name = "hot-air-0-a",
        ingredients = {},
        results = {
            {type = "fluid", name = "hot-air", amount = 25}
        },
        energy_required = 1.0,
        constituent_buildings = {
            {"transport-belt", 20},
            {"pipe-to-ground", 10},
            {"pipe", 15},
            {"small-electric-pole", 15},
            {"fast-inserter", 15},
            {"soil-extractormk01", 4},
            {"washer", 2},
            {"offshore-pump", 1},
            {"py-sinkhole", 1},
            {"advanced-foundry-mk01", 4},
            {"vacuum-pump-mk01", 2},
            {"rhe", 1}
        },
        size = 16,
        energy_usage = "4MW",
        emissions_per_minute = 38.18,
        unlocked_by = cflib.base_technology
    }

    cflib.add_composite_factory{
        name = "carbon-dioxide-0-a",
        ingredients = {},
        results = {
            {type = "fluid", name = "carbon-dioxide", amount = 250}
        },
        energy_required = 1.0,
        constituent_buildings = {
            {"transport-belt", 60},
            {"tree-mk01", 50},
            {"moss", 30},
            {"pipe-to-ground", 30},
            {"pipe", 30},
            {"small-electric-pole", 15},
            {"fast-inserter", 20},
            {"hpf", 4},
            {"moss-farm-mk01", 2},
            {"offshore-pump", 1},
            {"fwf-mk01", 2},
            {"botanical-nursery", 2},
            {"compost-plant-mk01", 1},
            {"assembling-machine-1", 1},
            {"offshore-pump", 1},
            {"storage-tank", 1},
            {"wpu", 1},
            {"py-overflow-valve", 1}
        },
        size = 24,
        energy_usage = "3MW",
        emissions_per_minute = -165.81,
        unlocked_by = cflib.base_technology
    }

    cflib.add_composite_factory{
        name = "syngas-0-a",
        ingredients = {},
        results = {
            {type = "fluid", name = "syngas", amount = 250}
        },
        energy_required = 1.0,
        constituent_buildings = {
            {"transport-belt", 120},
            {"pipe-to-ground", 150},
            {"pipe", 150},
            {"small-electric-pole", 40},
            {"fast-inserter", 25},
            {"underground-belt", 16},
            {"soil-extractormk01", 8},
            {"long-handed-inserter", 8},
            {"electrolyzer-mk01", 6},
            {"washer", 4},
            {"offshore-pump", 3},
            {"vacuum-pump-mk01", 2},
            {"py-gas-vent", 2},
            {"py-sinkhole", 1},
            {"py-underflow-valve", 1},
            {"distilator", 1},
            {"storage-tank", 1}
        },
        size = 36,
        energy_usage = "12MW",
        emissions_per_minute = 1.56,
        unlocked_by = cflib.base_technology
    }
end
