execute at @p run tp @s ~ ~ ~ 0 0
function skys_horizon:space/apply_uniforms

execute store result entity @s item.components."minecraft:custom_model_data".floats[0] float 0.01 run scoreboard players get @p skys_horizon.space.pitch
execute store result entity @s item.components."minecraft:custom_model_data".floats[1] float 0.01 run scoreboard players get @p skys_horizon.space.yaw
execute store result entity @s item.components."minecraft:custom_model_data".floats[2] float 0.01 run scoreboard players get @p skys_horizon.space.roll
