execute if score $20 skys_horizon.timer matches 0 if entity @n[type=minecraft:player, predicate=!skys_horizon:spaceship/is_mounted, distance=..10] run function skys_horizon:spaceship/hitbox/update
execute if dimension skys_horizon:space run function skys_horizon:spaceship/space/update
execute unless dimension skys_horizon:space run function skys_horizon:spaceship/surface/update
function skys_horizon:spaceship/velocity/update_velocity
