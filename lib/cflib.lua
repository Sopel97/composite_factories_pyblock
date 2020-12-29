do
    -- Maybe make it as a separete library mod later on?

    local cflib = {}

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

    cflib.add_technology = function(args)
        local full_name = name_prefix .. args.name

        data:extend({{
            type = "technology",
            name = full_name,
            -- placeholder
            icon = "__base__/graphics/icons/assembling-machine-1.png",
            icon_size = 64,
            effects = {},
            prerequisites = args.prerequisites,
            order = "g-e-d",
            unit = {
                count = args.num_units,
                ingredients = args.unit_ingredients,
                time = args.unit_time
            }
        }})

        return full_name
    end

    cflib.base_technology = cflib.add_technology{
        name = "base-technology",
        prerequisites = {"logistic-science-pack"},
        num_units = 500,
        unit_ingredients = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1}
        },
        unit_time = 60
    }

    local function add_recipe_unlock(recipe, technology)
        table.insert(data.raw.technology[technology].effects, {
            type = "unlock-recipe",
            recipe = recipe
        })
    end

    local function count_fluids(things)
        local num_fluids = 0
        for _, e in pairs(things) do
            if e.type and e.type == "fluid" then
                num_fluids = num_fluids + 1
            end
        end
        return num_fluids
    end

    cflib.add_composite_factory = function(args)
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

        local composite_factory_recipe_enabled = args.unlocked_by == nil

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
            enabled = composite_factory_recipe_enabled,
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
                drain = "0W"
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
                        hr_version = {
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
                        hr_version = {
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

        if args.unlocked_by then
            add_recipe_unlock(composite_factory_recipe_name, args.unlocked_by)
        end
    end

    cflib.add_composite_generator = function(args)
        if #args.ingredients ~= 0 then
            error("Only generators without ingredients are supported right now.")
        end

        local full_name = name_prefix .. args.name
        local composite_factory_entity_name = full_name .. "-generator"
        local composite_factory_recipe_name = full_name .. "-generator"
        local composite_factory_item_name = full_name .. "-generator"
        local base_sprite_size = 3
        local base_hr_sprite_size = 6
        local half_size = args.size / 2

        local enabled = args.unlocked_by == nil

        -- Composite factory building item recipe
        data:extend({{
            type = "recipe",
            name = composite_factory_recipe_name,
            enabled = composite_factory_recipe_enabled,
            energy_required = 600.0,
            category = "crafting",
            ingredients = args.constituent_buildings,
            results = {
                {composite_factory_entity_name, 1}
            }
        }})

        -- Composite factory item
        data:extend({{
            type = "item",
            name = composite_factory_item_name,
            icon = "__base__/graphics/icons/solar-panel.png",
            icon_size = 64,
            flags = {},
            subgroup = composite_factory_item_group_name,
            order = "b",
            place_result = composite_factory_entity_name,
            stack_size = 1
        }})

        data:extend({{
            type = "electric-energy-interface",
            name = composite_factory_entity_name,
            icons = { {icon = "__base__/graphics/icons/solar-panel.png", tint = {r=1, g=0.6, b=0.8, a=1}} },
            icon_size = 64, icon_mipmaps = 4,
            flags = {"placeable-neutral", "player-creation"},
            minable = {mining_time = 1, result = composite_factory_item_name},
            max_health = 10000,
            corpse = "medium-remnants",
            subgroup = "other",
            collision_box = {{-half_size+0.1, -half_size+0.1}, {half_size-0.1, half_size-0.1}},
            selection_box = {{-half_size, -half_size}, {half_size, half_size}},
            gui_mode = "none",
            energy_source =
            {
                type = "electric",
                buffer_capacity = buffer_size,
                usage_priority = "tertiary"
            },
            energy_production = args.energy_production,
            energy_usage = "0W",
            -- also 'pictures' for 4-way sprite is available, or 'animation' resp. 'animations'picture =
            picture = {
                layers =
                {
                    {
                        filename = "__base__/graphics/entity/solar-panel/solar-panel.png",
                        priority = "high",
                        width = 116,
                        height = 112,
                        shift = util.by_pixel(-3, 3),
                        scale = args.size / base_sprite_size,
                        hr_version = {
                            filename = "__base__/graphics/entity/solar-panel/hr-solar-panel.png",
                            priority = "high",
                            width = 230,
                            height = 224,
                            shift = util.by_pixel(-3, 3.5),
                            scale = args.size / base_hr_sprite_size
                        }
                    },
                    {
                        filename = "__base__/graphics/entity/solar-panel/solar-panel-shadow.png",
                        priority = "high",
                        width = 112,
                        height = 90,
                        shift = util.by_pixel(10, 6),
                        draw_as_shadow = true,
                        scale = args.size / base_sprite_size,
                        hr_version = {
                            filename = "__base__/graphics/entity/solar-panel/hr-solar-panel-shadow.png",
                            priority = "high",
                            width = 220,
                            height = 180,
                            shift = util.by_pixel(9.5, 6),
                            draw_as_shadow = true,
                            scale = args.size / base_hr_sprite_size
                        }
                    }
                }
            },
            vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65}
        }})

        if args.unlocked_by then
            add_recipe_unlock(composite_factory_recipe_name, args.unlocked_by)
        end
    end

    return cflib
end