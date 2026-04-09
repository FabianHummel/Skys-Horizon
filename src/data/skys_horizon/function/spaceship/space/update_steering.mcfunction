execute store result score #tmp1 skys_horizon.temp run data get entity @s Rotation[0] 100
scoreboard players add #tmp1 skys_horizon.temp 18000
execute if score #tmp1 skys_horizon.temp matches 18000.. run scoreboard players remove #tmp1 skys_horizon.temp 36000
scoreboard players operation @s skys_horizon.space.yaw -= #tmp1 skys_horizon.temp

execute store result score #tmp1 skys_horizon.temp run data get entity @s Rotation[1] 100
scoreboard players operation @s skys_horizon.space.pitch += #tmp1 skys_horizon.temp
