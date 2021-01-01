do
    local core = require("private/core")

    global.cflib = {}

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

    local function setup_cache()
        global.cflib.prototypes = get_composite_factories_prototypes()
    end

    script.on_init(function()
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

        -- TODO: the exchange stuff

        game.get_player(event.player_index).print(event.entity.name)
        for _, p in pairs(global.cflib.prototypes) do
            game.get_player(event.player_index).print(p.item.name)
        end
    end)

    return global.cflib
end
