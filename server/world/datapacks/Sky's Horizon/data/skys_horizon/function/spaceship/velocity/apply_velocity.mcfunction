tag @s add skys_horizon.spaceship.apply_velocity
$execute rotated as @s positioned 0.0 0.0 0.0 positioned ^ ^ ^$(velocity_in_distance) summon minecraft:area_effect_cloud run data modify entity @e[type=minecraft:armor_stand,tag=skys_horizon.spaceship.apply_velocity,limit=1] Motion set from entity @s Pos
tag @s remove skys_horizon.spaceship.apply_velocity
kill @e[type=minecraft:area_effect_cloud]