do
    local core = require("private/core")

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
            game.get_player(event.player_index).print(1)
            return
        end

        if event.entity == nil then
            game.get_player(event.player_index).print(2)
            return
        end

        if event.entity.type ~= "container" then
            game.get_player(event.player_index).print(3)
            return
        end

        if event.entity.name ~= core.make_container_name("material-exchange-container") then
            game.get_player(event.player_index).print(4)
            return
        end

        -- TODO: the exchange stuff

        game.get_player(event.player_index).print(event.entity.name)
    end)

    return global.cflib
end
