# Map yaw rotation directly (w/ two decimals accuracy)
execute store result entity @s Rotation[0] float 0.01 run scoreboard players get @p skys_horizon.space.yaw
execute store result entity @s OnGround byte 1 if data entity @s {OnGround:0b}

# Map pitch and roll axis to color channels (4.096 different values for each axis)
execute store result entity @s item.components."minecraft:dyed_color" int 1 run scoreboard players get #out skys_horizon.temp
