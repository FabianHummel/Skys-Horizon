execute as @p at @s run rotate @s ~ 0
scoreboard players add @p skys_horizon.space.pitch 20
scoreboard players add @p skys_horizon.space.roll 20
execute as @p run function skys_horizon:space/rotation_to_color
execute store result entity @e[tag=skys_horizon.celestial.planet,limit=1] item.components."minecraft:dyed_color" int 1 run scoreboard players get #out skys_horizon.temp
