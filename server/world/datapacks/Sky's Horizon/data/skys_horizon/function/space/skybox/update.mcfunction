execute at @p run tp @s ~ ~ ~ 0 0

# Map intensity directly (w/ two decimals accuracy)
execute store result entity @s Rotation[0] float 0.01 run scoreboard players get @p skys_horizon.space.warp_time
execute store result entity @s OnGround byte 1 if data entity @s {OnGround:0b}

# Map 0°-90° rotation to color (256 different values per axis)
execute store result entity @s item.components."minecraft:dyed_color" int 1 run scoreboard players get #out skys_horizon.temp

# Map rotation to custom model data to dynamically change model based on rotation (for a total of 1.024 different values per axis)
execute store result entity @s item.components."minecraft:custom_model_data".floats[0] float 0.01 run scoreboard players get @p skys_horizon.space.pitch
execute store result entity @s item.components."minecraft:custom_model_data".floats[1] float 0.01 run scoreboard players get @p skys_horizon.space.yaw
execute store result entity @s item.components."minecraft:custom_model_data".floats[2] float 0.01 run scoreboard players get @p skys_horizon.space.roll
