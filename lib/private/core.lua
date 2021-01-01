do
    local core = {}

    core.name_prefix = "composite-factory-"
    core.item_group_name = core.name_prefix .. "items"
    core.processing_recipe_group_name = core.name_prefix .. "processing"
    core.processing_recipe_category_name = core.name_prefix .. "processing"

    core.make_container_name = function(name)
        return core.name_prefix .. name
    end

    core.make_technology_name = function(name)
        return core.name_prefix .. name
    end

    core.make_composite_factory_name = function(name)
        return core.name_prefix .. name .. "-factory"
    end

    core.make_processing_recipe_name = function(name)
        return core.name_prefix .. name .. "-processing"
    end

    core.make_generator_name = function(name)
        return core.name_prefix .. name .. "-generator"
    end

    core.is_mod_prefixed_name = function(name)
        local found = string.find(name, core.name_prefix, 1, true)
        return found and found == 1
    end

    return core
end