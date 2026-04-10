# TODO: Yaw and Pitch rotation (and fix shader!)
#execute store result score #tmp1 skys_horizon.temp run data get entity @s Rotation[0] 100
#scoreboard players add #tmp1 skys_horizon.temp 18000
#execute if score #tmp1 skys_horizon.temp matches 18000.. run scoreboard players remove #tmp1 skys_horizon.temp 36000
#scoreboard players operation @s skys_horizon.space.yaw -= #tmp1 skys_horizon.temp
#
#execute store result score #tmp1 skys_horizon.temp run data get entity @s Rotation[1] 100
#scoreboard players operation @s skys_horizon.space.pitch += #tmp1 skys_horizon.temp

# Update roll velocity based on player input
execute if predicate skys_horizon:spaceship/steering/steering_left run scoreboard players operation @s skys_horizon.spaceship.roll_velocity -= #roll_acceleration skys_horizon.spaceship.const
execute if predicate skys_horizon:spaceship/steering/steering_right run scoreboard players operation @s skys_horizon.spaceship.roll_velocity += #roll_acceleration skys_horizon.spaceship.const
execute unless predicate skys_horizon:spaceship/steering/steering_right if score @s skys_horizon.spaceship.roll_velocity matches 0.. run function skys_horizon:spaceship/space/decelerate_roll
execute unless predicate skys_horizon:spaceship/steering/steering_left if score @s skys_horizon.spaceship.roll_velocity matches ..0 run function skys_horizon:spaceship/space/decelerate_roll

# Clamp roll velocity
scoreboard players operation @s skys_horizon.spaceship.roll_velocity < #max_roll_velocity skys_horizon.spaceship.const
scoreboard players operation @s skys_horizon.spaceship.roll_velocity > #min_roll_velocity skys_horizon.spaceship.const

# Update roll based on roll velocity
scoreboard players operation @s skys_horizon.space.roll -= @s skys_horizon.spaceship.roll_velocity
