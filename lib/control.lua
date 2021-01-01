do
    local core = require("private/core")

    local function get_composite_factories_prototypes()
        local factories = {}

        for name, e in pairs(game.entity_prototypes) do
            if e.type == "assembling-machine" or e.type == "electric-energy-interface" then
                if core.is_mod_prefixed_name(name) then
                    entity = e
                    recipe = game.recipe_prototypes[name]
                    item = game.item_prototypes[name]
                    table.insert(factories, {entity = entity, recipe = recipe, item = item})
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
            local recipe = prototypes.recipe
            local item = prototypes.item
            local name = entity.name

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

            local building_ingredients_flow = exchange_table.add{
                type = "table",
                column_count = 10,
                name = building_ingredients_panel_name
            }
            building_ingredients_flow.add{
                type = "sprite-button",
                enabled = false,
                sprite = "item/" .. item.name,
                number = 12345
            }

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
            player.print(p.item.name)
        end
    end)
end
