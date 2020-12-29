do
    local name_prefix = "composite-factory-"
    local composite_factory_item_group_name = name_prefix .. "buildings"
    local item_recipe_group_name = name_prefix .. "processing"
    local item_recipe_category = name_prefix .. "processing"

    data:extend {
      {
          type = "item-group",
          name = composite_factory_item_group_name,
          order = "z",
          inventory_order = "z",
          icon = "__composite_factories_pyblock__/graphics/item-group-buildings.png",
          icon_size = 64
      },
      {
          type = "item-subgroup",
          name = composite_factory_item_group_name,
          group = composite_factory_item_group_name,
          order = "a"
      },
      {
          type = "item-group",
          name = item_recipe_group_name,
          order = "z",
          inventory_order = "z",
          icon = "__composite_factories_pyblock__/graphics/item-group-buildings.png",
          icon_size = 64
      },
      {
          type = "item-subgroup",
          name = item_recipe_group_name,
          group = item_recipe_group_name,
          order = "a"
      }
    }

    data:extend {
      {
          type = "recipe-category",
          name = item_recipe_category
      }
    }

    local function count_fluids(things)
        local num_fluids = 0
        for _, e in pairs(things) do
            if e.type and e.type == "fluid" then
                num_fluids = num_fluids + 1
            end
        end
        return num_fluids
    end

    local function add_composite_factory(args)
        local full_name = name_prefix .. args.name
        local composite_factory_entity_name = full_name .. "-factory"
        local composite_factory_recipe_name = full_name .. "-factory"
        local composite_factory_item_name = full_name .. "-factory"
        local item_recipe_name = full_name
        local base_sprite_size = 3
        local base_hr_sprite_size = 6
        local half_size = args.size / 2

        local num_fluid_inputs = count_fluids(args.ingredients)
        local num_fluid_outputs = count_fluids(args.results)

        local fluid_boxes = {
            off_when_no_fluid_recipe = true
        }

        local fluid_input_spacing = args.size / (num_fluid_inputs+1)
        for i=1, num_fluid_inputs do
            table.insert(fluid_boxes, {
                production_type = "input",
                pipe_picture = assembler2pipepictures(),
                pipe_covers = pipecoverspictures(),
                base_area = 10,
                base_level = -1,
                pipe_connections = {{ type="input", position = {-half_size + i * fluid_input_spacing, -half_size-0.5} }},
                secondary_draw_orders = { north = -1 }
            })
        end

        local fluid_output_spacing = args.size / (num_fluid_outputs+1)
        for i=1, num_fluid_outputs do
            table.insert(fluid_boxes, {
                production_type = "output",
                pipe_picture = assembler2pipepictures(),
                pipe_covers = pipecoverspictures(),
                base_area = 10,
                base_level = -1,
                pipe_connections = {{ type="output", position = {-half_size + i * fluid_output_spacing, half_size+0.5} }},
                secondary_draw_orders = { north = -1 }
            })
        end

        -- Composite factory building item recipe
        data:extend({{
            type = "recipe",
            name = composite_factory_recipe_name,
            enabled = true,
            energy_required = 600.0,
            category = "crafting",
            ingredients = args.constituent_buildings,
            results = {
                {composite_factory_entity_name, 1}
            }
        }})

        -- Composite factory product recipe
        if #args.results == 1 then
            data:extend({{
                type = "recipe",
                name = item_recipe_name,
                energy_required = args.energy_required,
                enabled = true,
                category = item_recipe_category,
                subgroup = item_recipe_group_name,
                order = "b",
                ingredients = args.ingredients,
                results = args.results
            }})
        else
            data:extend({{
                type = "recipe",
                name = item_recipe_name,
                energy_required = args.energy_required,
                enabled = true,
                category = item_recipe_category,
                -- TODO: generate an icon
                icon = "__base__/graphics/icons/assembling-machine-1.png",
                subgroup = item_recipe_group_name,
                order = "b",
                icon_size = 64,
                ingredients = args.ingredients,
                results = args.results
            }})
        end

        -- Composite factory item
        data:extend({{
            type = "item",
            name = composite_factory_item_name,
            icon = "__base__/graphics/icons/assembling-machine-1.png",
            icon_size = 64,
            flags = {},
            subgroup = composite_factory_item_group_name,
            order = "b",
            place_result = composite_factory_entity_name,
            stack_size = 1
        }})

        -- Composite factory entity
        data:extend({{
            type = "assembling-machine",
            name = composite_factory_entity_name,
            fixed_recipe = item_recipe_name,
            icon = "__base__/graphics/icons/assembling-machine-1.png",
            icon_size = 64,
            flags = {"placeable-neutral", "player-creation"},
            minable = {mining_time = 1, result = composite_factory_item_name},
            max_health = 10000,
            corpse = "medium-remnants",
            dying_explosion = "medium-explosion",
            collision_box = {{-half_size+0.1, -half_size+0.1}, {half_size-0.1, half_size-0.1}},
            selection_box = {{-half_size, -half_size}, {half_size, half_size}},
            match_animation_speed_to_activity = false,
            crafting_categories = {item_recipe_category},
            scale_entity_info_icon = true,
            module_specification = {
                module_slots = 1
            },
            allowed_effects = {"consumption", "speed", "productivity", "pollution"},
            crafting_speed = 1,
            energy_source = {
                type = "electric",
                usage_priority = "secondary-input",
                emissions_per_minute = args.emissions_per_minute,
            },
            energy_usage = args.energy_usage,
            animation = {
                layers = {
                    {
                        filename = "__base__/graphics/entity/assembling-machine-1/assembling-machine-1.png",
                        priority="high",
                        width = 108,
                        height = 114,
                        frame_count = 32,
                        line_length = 8,
                        shift = util.by_pixel(0, 2),
                        scale = args.size / base_sprite_size,
                        hr_version =
                        {
                            filename = "__base__/graphics/entity/assembling-machine-1/hr-assembling-machine-1.png",
                            priority="high",
                            width = 214,
                            height = 226,
                            frame_count = 32,
                            line_length = 8,
                            shift = util.by_pixel(0, 2),
                            scale = args.size / base_hr_sprite_size
                        }
                    },
                    {
                        filename = "__base__/graphics/entity/assembling-machine-1/assembling-machine-1-shadow.png",
                        priority="high",
                        width = 95,
                        height = 83,
                        frame_count = 1,
                        line_length = 1,
                        repeat_count = 32,
                        draw_as_shadow = true,
                        shift = util.by_pixel(8.5, 5.5),
                        scale = args.size / base_sprite_size,
                        hr_version =
                        {
                            filename = "__base__/graphics/entity/assembling-machine-1/hr-assembling-machine-1-shadow.png",
                            priority="high",
                            width = 190,
                            height = 165,
                            frame_count = 1,
                            line_length = 1,
                            repeat_count = 32,
                            draw_as_shadow = true,
                            shift = util.by_pixel(8.5, 5),
                            scale = args.size / base_hr_sprite_size
                        }
                    }
                }
            },
            fluid_boxes = fluid_boxes,
            vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
            working_sound =
            {
                sound = {
                    {
                        filename = "__base__/sound/assembling-machine-t1-1.ogg",
                        volume = 0.5
                    }
                },
                audible_distance_modifier = 0.5,
                fade_in_ticks = 4,
                fade_out_ticks = 20
            }
        }})
    end

    add_composite_factory{
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
        emissions_per_minute = 1
    }

    add_composite_factory{
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
        emissions_per_minute = 1
    }
end