#rotate @s ~1 ~
#execute if entity @s[y_rotation=360] run rotate @s 0 ~
scoreboard players set $r spacewarp_rot 255
execute store result score $g spacewarp_rot run data get entity @s Rotation[0] 0.7083333333
execute store result score $b spacewarp_rot run data get entity @s Rotation[1] -1.4166666667
scoreboard players add $b spacewarp_rot 128

scoreboard players operation $r spacewarp_rot *= .65536 spacewarp_rot
scoreboard players operation $g spacewarp_rot *= .256 spacewarp_rot

scoreboard players operation $rgb spacewarp_rot = $b spacewarp_rot
scoreboard players operation $rgb spacewarp_rot += $g spacewarp_rot
scoreboard players operation $rgb spacewarp_rot += $r spacewarp_rot

execute store result entity @s item.components."minecraft:dyed_color" int 1 run scoreboard players get $rgb spacewarp_rot