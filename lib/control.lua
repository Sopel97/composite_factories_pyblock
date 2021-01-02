do
    local core = require("private/core")

    local cflib = {
        init_flags = {},
        event_handlers = {}
    }

    local function multi_index_set(table, indices, value)
        local t = table
        local num_indices = #indices

        for i=1,num_indices do
            local j = indices[i]
            if i == num_indices then
                t[j] = value
            else
                if not t[j] then
                    t[j] = {}
                end
                t = t[j]
            end
        end
    end

    local function multi_index_get(table, indices)
        local t = table
        local num_indices = #indices

        for i=1,num_indices do
            local j = indices[i]
            if not t[j] then
                return nil
            end
            t = t[j]
        end

        return t
    end

    local function is_initialized(player, name)
        local player_index = player.index

        return multi_index_get(cflib.init_flags, {player_index, name})
    end

    local function set_initialized(player, name)
        local player_index = player.index

        multi_index_set(cflib.init_flags, {player_index, name}, true)
    end

    local function get_composite_factories_prototypes()
        local factories = {}

        for name, e in pairs(game.entity_prototypes) do
            if e.type == "assembling-machine" then
                if core.is_mod_prefixed_name(name) then
                    raw_name = core.unmake_composite_factory_name(name)
                    processing_recipe_name = core.make_processing_recipe_name(raw_name)

                    entity = e
                    processing_recipe = game.recipe_prototypes[processing_recipe_name]
                    entity_item = game.item_prototypes[name]
                    entity_item_recipe = game.recipe_prototypes[name]

                    table.insert(factories, {
                        entity = entity,
                        processing_recipe = processing_recipe,
                        entity_item = entity_item,
                        entity_item_recipe = entity_item_recipe
                    })
                end
            elseif e.type == "electric-energy-interface" then
                if core.is_mod_prefixed_name(name) then
                    entity = e
                    entity_item = game.item_prototypes[name]
                    entity_item_recipe = game.recipe_prototypes[name]

                    table.insert(factories, {
                        entity = entity,
                        entity_item = entity_item,
                        entity_item_recipe = entity_item_recipe
                    })
                end
            end
        end

        return factories
    end

    local function add_gui_event_handler(event_type, player, gui_element_name, func)
        local player_index = player.index

        multi_index_set(cflib.event_handlers, {player_index, event_type, gui_element_name}, func)
    end

    local function get_gui_event_handler(event_type, event)
        local player_index = event.player_index
        local gui_element_name = event.element.name

        return multi_index_get(cflib.event_handlers, {player_index, event_type, gui_element_name})
    end

    local function setup_material_exchange_container_gui(player)
        local gui_name = core.make_gui_element_name("material-exchange-container-gui")
        local main_pane_name = core.make_gui_element_name("material-exchange-container-gui-main-pane")
        local exchange_table_name = core.make_gui_element_name("material-exchange-container-gui-exchange-table")

        local gui = player.gui.relative.add{
            type = "frame",
            name = gui_name,
            direction = "vertical",
            caption = "Material Exchange",
            anchor = {
                gui = defines.relative_gui_type.container_gui,
                position = defines.relative_gui_position.right,
                name = core.make_container_name("material-exchange-container")
            }
        }

        local main_gui_pane = gui.add{
            type = "scroll-pane",
            name = main_pane_name,
            vertical_scroll_policy = "auto-and-reserve-space"
        }

        local exchange_table = main_gui_pane.add{
            type = "table",
            name = exchange_table_name,
            -- Craft | Show/hide button | Icon/hidden building ingredients | Product summary | Energy required | Ingredient summary
            column_count = 6,
            draw_vertical_lines = true,
            draw_horizontal_lines = true,
            draw_horizontal_line_after_header = true,
            vertical_centering = false
        }

        local add_exchange_item = function(prototypes)
            local entity = prototypes.entity
            local name = entity.name
            local entity_item = prototypes.entity_item
            local entity_item_recipe = prototypes.entity_item_recipe
            local processing_recipe = prototypes.processing_recipe

            local craft_button_name = core.make_gui_element_name("material-exchange-container-gui-exchange-table-craft-" .. name)
            local building_ingredients_flow_name = core.make_gui_element_name("material-exchange-container-gui-exchange-table-building-ingredients-flow-" .. name)
            local building_ingredients_panel_name = core.make_gui_element_name("material-exchange-container-gui-exchange-table-building-ingredients-panel-" .. name)
            local building_ingredients_preview_panel_name = core.make_gui_element_name("material-exchange-container-gui-exchange-table-building-ingredients-preview-panel-" .. name)
            local toggle_visibility_button_name = core.make_gui_element_name("material-exchange-container-gui-exchange-table-toggle-visibility-button-" .. name)

            local num_building_ingredients_columns = 5;
            local num_processing_recipe_ingredients_columns = 3;
            local num_processing_recipe_products_columns = 3;

            exchange_table.add{
                type = "button",
                name = craft_button_name,
                caption = "Craft 1"
            }

            local toggle_visibility_button = exchange_table.add{
                type = "button",
                name = toggle_visibility_button_name,
                caption = "S"
            }

            local building_ingredients_flow = exchange_table.add{
                type = "flow",
                direction = "vertical",
                name = building_ingredients_flow_name
            }

            local building_ingredients_preview_panel = building_ingredients_flow.add{
                type = "table",
                column_count = num_building_ingredients_columns,
                name = building_ingredients_preview_panel_name
            }

            local building_ingredients_panel = building_ingredients_flow.add{
                type = "table",
                column_count = num_building_ingredients_columns,
                name = building_ingredients_panel_name,
                visible = false
            }

            do
                local i = 0
                for _, ingredient in pairs(entity_item_recipe.ingredients) do
                    local name = ingredient.name
                    local type = ingredient.type
                    local amount = ingredient.amount
                    local item = (type == "item" and game.item_prototypes[name]) or (type == "fluid" and game.fluid_prototypes[name])

                    local args = {
                        type = "sprite-button",
                        enabled = false,
                        sprite = type .. "/" .. name,
                        number = amount,
                        tooltip = {"", amount, "x ", item.localised_name}
                    }

                    building_ingredients_panel.add(args)

                    if i < num_building_ingredients_columns - 1 then
                        building_ingredients_preview_panel.add(args)
                    elseif i == num_building_ingredients_columns - 1 then
                        building_ingredients_preview_panel.add{
                            type = "label",
                            caption = "   ...   "
                        }
                    end

                    i = i + 1
                end
            end

            local product_summary_panel = exchange_table.add{
                type = "table",
                column_count = num_processing_recipe_products_columns,
                direction = "vertical"
            }

            if entity.type == "electric-energy-interface" then
                local energy_produced_mw = entity.max_energy_production * 60.0 / 1000000.0

                product_summary_panel.add{
                    type = "label",
                    caption = energy_produced_mw .. "MW"
                }
            elseif entity.type == "assembling-machine" and processing_recipe then
                for _, product in pairs(processing_recipe.products) do
                    local name = product.name
                    local type = product.type
                    local amount = product.amount
                    local item = (type == "item" and game.item_prototypes[name]) or (type == "fluid" and game.fluid_prototypes[name])

                    product_summary_panel.add{
                        type = "sprite-button",
                        enabled = false,
                        sprite = type .. "/" .. name,
                        number = amount,
                        tooltip = {"", amount, "x ", item.localised_name}
                    }
                end
            end

            local energy_required_panel = exchange_table.add{
                type = "flow",
                direction = "vertical"
            }

            if processing_recipe then
                energy_required_panel.add{
                    type = "sprite-button",
                    enabled = false,
                    sprite = core.time_duration_indicator_sprite_name,
                    number = processing_recipe.energy
                }
            end

            local ingredient_summary_panel = exchange_table.add{
                type = "table",
                column_count = num_processing_recipe_ingredients_columns,
                direction = "vertical"
            }

            if processing_recipe then
                for _, ingredient in pairs(processing_recipe.ingredients) do
                    local name = ingredient.name
                    local type = ingredient.type
                    local amount = ingredient.amount
                    local item = (type == "item" and game.item_prototypes[name]) or (type == "fluid" and game.fluid_prototypes[name])

                    ingredient_summary_panel.add{
                        type = "sprite-button",
                        enabled = false,
                        sprite = type .. "/" .. name,
                        number = amount,
                        tooltip = {"", amount, "x ", item.localised_name}
                    }
                end
            end
        end

        for _, p in pairs(global.prototypes) do
            add_exchange_item(p)
        end

        return gui
    end

    local function setup_material_exchange_container_gui_events(player)
        local gui_name = core.make_gui_element_name("material-exchange-container-gui")
        local main_pane_name = core.make_gui_element_name("material-exchange-container-gui-main-pane")
        local exchange_table_name = core.make_gui_element_name("material-exchange-container-gui-exchange-table")

        local exchange_table = player.gui.relative[gui_name][main_pane_name][exchange_table_name]

        local add_events_for_exchange_item = function(prototypes)
            local entity = prototypes.entity
            local name = entity.name

            local craft_button_name = core.make_gui_element_name("material-exchange-container-gui-exchange-table-craft-" .. name)
            local building_ingredients_flow_name = core.make_gui_element_name("material-exchange-container-gui-exchange-table-building-ingredients-flow-" .. name)
            local building_ingredients_panel_name = core.make_gui_element_name("material-exchange-container-gui-exchange-table-building-ingredients-panel-" .. name)
            local building_ingredients_preview_panel_name = core.make_gui_element_name("material-exchange-container-gui-exchange-table-building-ingredients-preview-panel-" .. name)
            local toggle_visibility_button_name = core.make_gui_element_name("material-exchange-container-gui-exchange-table-toggle-visibility-button-" .. name)

            local toggle_visibility_button = exchange_table[toggle_visibility_button_name]
            local building_ingredients_flow = exchange_table[building_ingredients_flow_name]
            local building_ingredients_preview_panel = building_ingredients_flow[building_ingredients_preview_panel_name]
            local building_ingredients_panel = building_ingredients_flow[building_ingredients_panel_name]

            add_gui_event_handler(defines.events.on_gui_click, player, toggle_visibility_button_name, function(event)
                player.print("asd")

                if toggle_visibility_button.caption == "S" then
                    toggle_visibility_button.caption = "H"
                else
                    toggle_visibility_button.caption = "S"
                end

                building_ingredients_preview_panel.visible = not building_ingredients_preview_panel.visible
                building_ingredients_panel.visible = not building_ingredients_panel.visible
            end)

        end

        for _, p in pairs(global.prototypes) do
            add_events_for_exchange_item(p)
        end

end

    local function get_material_exchange_container_gui(player)
        local material_exchange_container_gui_name = core.make_gui_element_name("material-exchange-container-gui")

        local gui = player.gui.relative[material_exchange_container_gui_name] or setup_material_exchange_container_gui(player)

        if not is_initialized(player, "material-exchange-container-gui") then
            setup_material_exchange_container_gui_events(player)
            set_initialized(player, "material-exchange-container-gui")
        end

        return gui
    end

    local function setup_cache()
        global.prototypes = get_composite_factories_prototypes()
    end

    script.on_init(function()
        setup_cache()
    end)

    script.on_configuration_changed(function(event)
        setup_cache()
    end)

    script.on_event(defines.events.on_gui_click, function(event)
        local handler = get_gui_event_handler(defines.events.on_gui_click, event)
        if handler then
            handler(event)
        end
    end)

    script.on_event(defines.events.on_gui_opened, function(event)
        if not event.gui_type == defines.gui_type.entity then
            return
        end

        if event.entity == nil then
            return
        end

        if event.entity.type ~= "container" then
            return
        end

        if event.entity.name ~= core.make_container_name("material-exchange-container") then
            return
        end

        local player = game.get_player(event.player_index)
        local gui = get_material_exchange_container_gui(player)

        player.print(event.entity.name)
        player.print(gui.name)
        for _, p in pairs(global.prototypes) do
            raw_name = core.unmake_composite_factory_name(p.entity.name)
            processing_recipe_name = core.make_processing_recipe_name(raw_name)
            player.print(processing_recipe_name)
        end
    end)
end
