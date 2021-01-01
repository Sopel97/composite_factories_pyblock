do
    local core = require("private/core")

    local function get_composite_factories_prototypes()
        local factories = {}

        for name, e in pairs(game.entity_prototypes) do
            if e.type == "assembling-machine" then
                if core.is_mod_prefixed_name(name) then
                    raw_name = core.unmake_composite_factory_name(name)
                    processing_recipe = core.make_processing_recipe_name(raw_name)

                    entity = e
                    processing_recipe = game.recipe_prototypes[processing_recipe]
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
            -- Craft | Show/hide button | Icon/hidden building ingredients | Product summary | Ingredient summary
            column_count = 5,
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

            local craft_button_name = core.make_gui_element_name("material-exchange-container-gui-exchange-table-craft-" .. name)
            local building_ingredients_panel_name = core.make_gui_element_name("material-exchange-container-gui-exchange-table-building-ingredients-panel-" .. name)
            local toggle_visibility_button_name = core.make_gui_element_name("material-exchange-container-gui-exchange-table-toggle-visibility-button-" .. name)

            exchange_table.add{
                type = "button",
                name = craft_button_name,
                caption = "Craft 1"
            }

            exchange_table.add{
                type = "button",
                name = toggle_visibility_button_name,
                caption = "S"
            }

            local building_ingredients_panel = exchange_table.add{
                type = "table",
                column_count = 10,
                name = building_ingredients_panel_name
            }

            for _, ingredient in pairs(entity_item_recipe.ingredients) do
                local name = ingredient.name
                local type = ingredient.type
                local amount = ingredient.amount
                local item = (type == "item" and game.item_prototypes[name]) or (type == "fluid" and game.fluid_prototypes[name])

                building_ingredients_panel.add{
                    type = "sprite-button",
                    enabled = false,
                    sprite = type .. "/" .. name,
                    number = amount,
                    tooltip = {"", ingredient.amount, "x ", item.localised_name}
                }
            end

            local product_summary_flow = exchange_table.add{
                type = "flow",
                direction = "vertical"
            }

            local ingredient_summary_flow = exchange_table.add{
                type = "flow",
                direction = "vertical"
            }
        end

        add_exchange_item(global.cflib.prototypes[1])

        return gui
    end

    local function get_material_exchange_container_gui(player)
        local material_exchange_container_gui_name = core.make_gui_element_name("material-exchange-container-gui")

        return player.gui.relative[material_exchange_container_gui_name] or setup_material_exchange_container_gui(player)
    end

    local function setup_cache()
        global.cflib.prototypes = get_composite_factories_prototypes()
    end

    script.on_init(function()
        global.cflib = {}

        setup_cache()
    end)

    script.on_configuration_changed(function(event)
        setup_cache()
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
        for _, p in pairs(global.cflib.prototypes) do
            player.print(p.entity_item.name)
        end
    end)
end
