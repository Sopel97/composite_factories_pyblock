do
    --[[ Examples:
    local test_tech_name = cflib.add_technology{
        name = "test-tech",
        prerequisites = {cflib.base_technology},
        num_units = 123,
        unit_ingredients = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 2},
            {"military-science-pack", 2},
            {"chemical-science-pack", 4},
            {"production-science-pack", 5},
            {"utility-science-pack", 6},
            {"space-science-pack", 7}
        },
        unit_time = 60
    }

    cflib.add_composite_factory{
        name = "iron-gear-wheel",
        ingredients = {
            {"iron-plate", 20}
        },
        results = {
            {"iron-gear-wheel", 10}
        },
        energy_required = 1.0,
        constituent_buildings = {
            {"assembling-machine-1", 10},
            {"transport-belt", 100},
            {"inserter", 20}
        },
        size = 12,
        energy_usage = "10MW",
        emissions_per_minute = 1,
        unlocked_by = test_tech_name
    }

    cflib.add_composite_factory{
        name = "test-fluids",
        ingredients = {
            {type="fluid", name="water", amount=20},
            {type="fluid", name="steam", amount=20},
            {type="fluid", name="sulfuric-acid", amount=20}
        },
        results = {
            {type="fluid", name="water", amount=20},
            {type="fluid", name="steam", amount=20}
        },
        energy_required = 1.0,
        constituent_buildings = {
            {"assembling-machine-1", 10},
            {"transport-belt", 100},
            {"inserter", 20}
        },
        size = 12,
        energy_usage = "10MW",
        emissions_per_minute = 1,
        unlocked_by = test_tech_name
    }

    cflib.add_composite_generator{
        name = "generator-test",
        ingredients = {},
        energy_production = "100MW",
        buffer_capacity = "100MJ",
        constituent_buildings = {
            {"boiler", 10},
            {"steam-engine", 20},
            {"solar-panel", 50},
            {"inserter", 20}
        },
        size = 12,
        unlocked_by = test_tech_name
    }
    --]]

    -- End of placeholder stuff
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
        size = 25,
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
        size = 22,
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
        size = 30,
        energy_usage = "14MW",
        emissions_per_minute = 2.57,
        unlocked_by = cflib.base_technology
    }

    cflib.add_composite_generator{
        name = "electricity-1-a",
        ingredients = {},
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
        size = 38,
        unlocked_by = cflib.base_technology
    }

    cflib.add_composite_generator{
        name = "electricity-1-b",
        ingredients = {},
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
        size = 30,
        unlocked_by = cflib.base_technology
    }
end
