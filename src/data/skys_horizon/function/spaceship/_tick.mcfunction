execute if score $20 skys_horizon.timer matches 0 run tag @e[type=minecraft:armor_stand, tag=skys_horizon.spaceship.hitbox] remove skys_horizon.spaceship.hitbox.placed
execute as @e[tag=skys_horizon.spaceship.base] at @s run function skys_horizon:spaceship/main
