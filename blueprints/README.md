# Blueprints

This directory contains text files with blueprint strings. Each file represents one composite factory and should be named the same as the composite factory (minus the mod prefix). For the purpose of these blueprints they will require VoidChess+ for item voiding, see the paragraph about voiding.

# General guidelines

## Voiding

In pyblock voiding fluids and gases is easy and fast. Generally any factory that voids fluids/gasses should require one sinkhole/vent to make.

Voiding items is more complicated as it requires fuel. Ideally we don't want to enforce the partial costs of voiding items for every building so we just take the cost in burners and electricity. Voiding 1 item/s costs \~100kW so we should use that. One burner can do 2.5 items/s assuming it has to void its produced ash.

# Size

The factories are generally huge and not square. Keeping the size the same after consolidation is not required and could be harmful to gameplay. For example making tar in quantities of 250/s requires a building of size roughly 50^2; but we make it smaller. Generally I think a good guideline is to use `sqrt(width*height)/2` per side, resulting in 1/4th of area.

# Ingredients

Round but not too much. Omit stuff that seems irrelevant.
