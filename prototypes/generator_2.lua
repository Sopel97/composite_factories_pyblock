do
    local circuit_2_tech = cflib.make_technology_name("circuit-2-technology")

    local item_subgroup = cflib.add_item_subgroup{
        name = "generator-2",
        order = "c-2"
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
        unlocked_by = circuit_2_tech,
        subgroup = item_subgroup
    }
end