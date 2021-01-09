do
    cflib.add_technology{
        name = "circuit-2-technology",
        prerequisites = {"basic-electronics", cflib.base_technology},
        num_units = 500,
        unit_ingredients = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        unit_time = 60
    }
end