do
    global.cflib = {}

    local function setup_cache()
        -- TODO: build exchange maps
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

        if entity == nil then
            return
        end

        -- TODO: the exchange stuff

        game.get_player(entity.player_index).print(entity.name)
    end, {{filter = "type", type = "container"}, {filter = "name", name = cflib.material_exchange_container}})

    return global.cflib
end
