execute at @p run tp @s ~ ~ ~ 0 0
skys_horizon:space/skybox/update_rotation

# Map 0°-90° rotation to color (256 different values per axis)
execute store result entity @s item.components."minecraft:dyed_color" int 1 run scoreboard players get #out skys_horizon.temp

# Map rotation to custom model data to dynamically change model based on rotation (for a total of 1.024 different values per axis)
execute store result entity @s item.components."minecraft:custom_model_data".floats[0] float 0.01 run scoreboard players get @p skys_horizon.space.pitch
execute store result entity @s item.components."minecraft:custom_model_data".floats[1] float 0.01 run scoreboard players get @p skys_horizon.space.yaw
execute store result entity @s item.components."minecraft:custom_model_data".floats[2] float 0.01 run scoreboard players get @p skys_horizon.space.roll
