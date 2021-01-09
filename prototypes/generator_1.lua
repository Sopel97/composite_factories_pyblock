do
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
end