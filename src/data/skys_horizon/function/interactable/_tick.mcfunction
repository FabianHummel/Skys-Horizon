execute as @a[gamemode=!adventure] run attribute @s minecraft:block_interaction_range base reset
execute as @a[gamemode=adventure] run attribute @s minecraft:block_interaction_range base set 0
tag @e[tag=skys_horizon.interactable] remove skys_horizon.interactable.active
execute store result storage skys_horizon temp.interaction_range double 1 run scoreboard players get $range skys_horizon.interactable
execute as @a at @s run function skys_horizon:interactable/main with storage skys_horizon temp
execute as @e[tag=skys_horizon.interactable] store result entity @s Glowing byte 1 if entity @s[tag=skys_horizon.interactable.active]
