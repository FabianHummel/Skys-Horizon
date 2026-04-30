execute store result entity @s item.components."minecraft:dyed_color" int 1 run scoreboard players get $rotation_color_precise skys_horizon.space
execute store result entity @s Rotation[0] float 0.001 run scoreboard players get $rotation_yaw skys_horizon.space
execute store result entity @s OnGround byte 1 if data entity @s {OnGround:0b}
