do
    local item_subgroup = cflib.add_item_subgroup{
        name = "factory-0",
        order = "b-0"
    }

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
        unlocked_by = cflib.base_technology,
        subgroup = item_subgroup
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
        unlocked_by = cflib.base_technology,
        subgroup = item_subgroup
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
        unlocked_by = cflib.base_technology,
        subgroup = item_subgroup
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
        unlocked_by = cflib.base_technology,
        subgroup = item_subgroup
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
            {"storage-tank", 1},
            {"wpu", 1},
            {"py-overflow-valve", 1}
        },
        size = 24,
        energy_usage = "3MW",
        emissions_per_minute = -165.81,
        unlocked_by = cflib.base_technology,
        subgroup = item_subgroup
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
        unlocked_by = cflib.base_technology,
        subgroup = item_subgroup
    }

    cflib.add_composite_factory{
        name = "dirty-water-0-a",
        ingredients = {},
        results = {
            {type = "fluid", name = "dirty-water", amount = 1000},
            {type = "fluid", name = "water-saline", amount = 500}
        },
        energy_required = 1.0,
        constituent_buildings = {
            {"transport-belt", 100},
            {"pipe-to-ground", 100},
            {"pipe", 70},
            {"small-electric-pole", 25},
            {"fast-inserter", 25},
            {"soil-extractormk01", 8},
            {"washer", 4},
            {"quenching-tower", 4},
            {"offshore-pump", 3},
            {"py-gas-vent", 1},
            {"py-sinkhole", 2},
            {"distilator", 1}
        },
        size = 30,
        energy_usage = "8MW",
        emissions_per_minute = 0.26,
        unlocked_by = cflib.base_technology,
        subgroup = item_subgroup
    }

    cflib.add_composite_factory{
        name = "wood-0-a",
        ingredients = {},
        results = {
            {"wood", 5}
        },
        energy_required = 1.0,
        constituent_buildings = {
            {"transport-belt", 350},
            {"tree-mk01", 175},
            {"moss", 90},
            {"pipe-to-ground", 75},
            {"pipe", 50},
            {"small-electric-pole", 70},
            {"fast-inserter", 50},
            {"underground-belt", 10},
            {"wpu", 10},
            {"fwf-mk01", 7},
            {"moss-farm-mk01", 6},
            {"botanical-nursery", 5},
            {"hpf", 2},
            {"compost-plant-mk01", 1},
            {"assembling-machine-1", 1},
            {"offshore-pump", 1}
        },
        size = 40,
        energy_usage = "6MW",
        emissions_per_minute = -600,
        unlocked_by = cflib.base_technology,
        subgroup = item_subgroup
    }

    cflib.add_composite_factory{
        name = "biomass-0-a",
        ingredients = {},
        results = {
            {"biomass", 9}
        },
        energy_required = 1.0,
        constituent_buildings = {
            {"transport-belt", 80},
            {"tree-mk01", 50},
            {"moss", 30},
            {"pipe-to-ground", 30},
            {"pipe", 30},
            {"small-electric-pole", 25},
            {"fast-inserter", 20},
            {"underground-belt", 4},
            {"wpu", 1},
            {"fwf-mk01", 2},
            {"moss-farm-mk01", 2},
            {"botanical-nursery", 2},
            {"hpf", 2},
            {"compost-plant-mk01", 1},
            {"assembling-machine-1", 1},
            {"offshore-pump", 1}
        },
        size = 23,
        energy_usage = "2MW",
        emissions_per_minute = -180,
        unlocked_by = cflib.base_technology,
        subgroup = item_subgroup
    }

    cflib.add_composite_factory{
        name = "methane-0-a",
        ingredients = {},
        results = {
            {type = "fluid", name = "methane", amount = 20}
        },
        energy_required = 1.0,
        constituent_buildings = {
            {"transport-belt", 400},
            {"pipe-to-ground", 100},
            {"pipe", 70},
            {"small-electric-pole", 50},
            {"fast-inserter", 25},
            {"long-handed-inserter", 10},
            {"filter-inserter", 2},
            {"moondrop", 360},
            {"moondrop-greenhouse-mk01", 18},
            {"electrolyzer-mk01", 1},
            {"compost-plant-mk01", 1},
            {"py-gas-vent", 1},
            {"soil-extractormk01", 1},
            {"botanical-nursery", 1},
            {"hpf", 1},
            {"offshore-pump", 1}
        },
        size = 40,
        energy_usage = "4MW",
        emissions_per_minute = -630,
        unlocked_by = cflib.base_technology,
        subgroup = item_subgroup
    }

    cflib.add_composite_factory{
        name = "fish-0-a",
        ingredients = {},
        results = {
            {"fish", 1},
            {type = "fluid", name = "waste-water", amount = 10}
        },
        energy_required = 1.0,
        constituent_buildings = {
            {"transport-belt", 230},
            {"fish", 112},
            {"pipe-to-ground", 110},
            {"seaweed", 60},
            {"pipe", 40},
            {"small-electric-pole", 60},
            {"inserter", 50},
            {"fish-farm-mk01", 16},
            {"seaweed-crop-mk01", 6},
            {"soil-extractormk01", 2},
            {"washer", 2},
            {"py-sinkhole", 1},
            {"offshore-pump", 1}
        },
        size = 46,
        energy_usage = "18MW",
        emissions_per_minute = -190,
        unlocked_by = cflib.base_technology,
        subgroup = item_subgroup
    }

    cflib.add_composite_factory{
        name = "aromatics-0-a",
        ingredients = {},
        results = {
            {type = "fluid", name = "aromatics", amount = 150},
            {type = "fluid", name = "benzene", amount = 150}
        },
        energy_required = 1.0,
        constituent_buildings = {
            {"transport-belt", 30},
            {"pipe-to-ground", 150},
            {"pipe", 120},
            {"small-electric-pole", 30},
            {"fast-inserter", 15},
            {"distilator", 17},
            {"py-sinkhole", 4},
            {"soil-extractormk01", 4},
            {"washer", 2},
            {"fluid-separator", 4},
            {"quenching-tower", 2},
            {"py-gas-vent", 1},
            {"offshore-pump", 1}
        },
        size = 36,
        energy_usage = "8MW",
        emissions_per_minute = 1.6,
        unlocked_by = cflib.base_technology,
        subgroup = item_subgroup
    }

    cflib.add_composite_factory{
        name = "salt-0-a",
        ingredients = {},
        results = {
            {"salt", 10}
        },
        energy_required = 1.0,
        constituent_buildings = {
            {"transport-belt", 10},
            {"pipe-to-ground", 20},
            {"pipe", 25},
            {"small-electric-pole", 10},
            {"fast-inserter", 10},
            {"soil-extractormk01", 2},
            {"washer", 1},
            {"py-sinkhole", 1},
            {"py-gas-vent", 1},
            {"quenching-tower", 1},
            {"evaporator", 1},
            {"distilator", 1},
            {"offshore-pump", 1}
        },
        size = 15,
        energy_usage = "3MW",
        emissions_per_minute = 0.24,
        unlocked_by = cflib.base_technology,
        subgroup = item_subgroup
    }
end
