# Fixate skybox to player
function skys_horizon:space/shared/fixate_to_player

# Map opacity to color
execute store result entity @s item.components."minecraft:dyed_color" int 1 run scoreboard players get @p skys_horizon.space.warp
