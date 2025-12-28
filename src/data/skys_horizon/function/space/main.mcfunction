# Update rotation
rotate @s 180 0
function skys_horizon:space/rotation_to_color
execute as @e[x=0,tag=skys_horizon.celestial.planet] store result entity @s item.components."minecraft:dyed_color" int 1 run scoreboard players get #out skys_horizon.temp

# Update space sky
tp @e[type=minecraft:item_display,tag=skys_horizon.celestial.background,limit=1,x=0] @s
