# Todo: teleport spaceship instead (and to correct location)
execute in skys_horizon:space run tp @s 0 20 -60 0 0
execute in skys_horizon:space run tp @n[tag=skys_horizon.spaceship] 0 20 -60 0 0
function skys_horizon:space/reset_rotation
effect give @s minecraft:invisibility infinite 1 true
