execute as @n[tag=skys_horizon.spaceship.model] at @s run function skys_horizon:spaceship/zzz/update_model
execute if score $20 skys_horizon.timer matches 0 if entity @n[type=minecraft:player, predicate=!skys_horizon:spaceship/is_mounted, distance=..10] run function skys_horizon:spaceship/hitbox/update_hitboxes
execute unless dimension skys_horizon:space run function skys_horizon:spaceship/surface/update
execute if dimension skys_horizon:space run function skys_horizon:spaceship/space/update
function skys_horizon:spaceship/velocity/update_velocity
