do
    local cflib = require("lib/cflib")

    local test_tech_name = cflib.add_technology{
        name = "test-tech",
        prerequisites = {},
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
end