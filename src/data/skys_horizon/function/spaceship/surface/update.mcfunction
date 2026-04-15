function skys_horizon:space/shared/reset_rotation

# Update steering velocity based on player input
execute if predicate skys_horizon:spaceship/steering/steering_left run scoreboard players operation @s skys_horizon.spaceship.steering -= #steering_acceleration skys_horizon.spaceship.const
execute if predicate skys_horizon:spaceship/steering/steering_right run scoreboard players operation @s skys_horizon.spaceship.steering += #steering_acceleration skys_horizon.spaceship.const

# Center steering when no input
execute unless predicate skys_horizon:spaceship/steering/steering_right if score @s skys_horizon.spaceship.steering matches 0.. run function skys_horizon:spaceship/surface/steering_center
execute unless predicate skys_horizon:spaceship/steering/steering_left if score @s skys_horizon.spaceship.steering matches ..0 run function skys_horizon:spaceship/surface/steering_center

# Clamp roll velocity
scoreboard players operation @s skys_horizon.spaceship.steering < #max_steering_velocity skys_horizon.spaceship.const
scoreboard players operation @s skys_horizon.spaceship.steering > #min_steering_velocity skys_horizon.spaceship.const

# Rotate spaceship on the roll-axis based on steering value
execute store result entity @e[tag=skys_horizon.spaceship.model,limit=1,sort=nearest] transformation.right_rotation[2] double 0.01 run scoreboard players get @s skys_horizon.spaceship.steering

# Rotate spaceship and player
execute store result storage skys_horizon spaceship.rotation_to_add double 0.05 run scoreboard players get @s skys_horizon.spaceship.steering
execute as @e[tag=skys_horizon.spaceship.model,limit=1,sort=nearest] at @s run function skys_horizon:spaceship/surface/apply_rotation with storage skys_horizon spaceship
function skys_horizon:spaceship/surface/apply_rotation with storage skys_horizon spaceship
execute rotated as @e[tag=skys_horizon.spaceship.model,limit=1,sort=nearest] run rotate @e[tag=skys_horizon.spaceship.base,limit=1,sort=nearest] ~ ~

# Limit spaceship roll based on velocity (higher velocity means higher maximum roll)
scoreboard players operation #tmp1 skys_horizon.temp = @s skys_horizon.spaceship.velocity
scoreboard players operation #tmp1 skys_horizon.temp -= #max_realistic_velocity skys_horizon.spaceship.const
execute if score #tmp1 skys_horizon.temp matches -100.. run scoreboard players set #tmp1 skys_horizon.temp -100
execute store result entity @e[tag=skys_horizon.spaceship.model,limit=1,sort=nearest] transformation.right_rotation[3] double -0.01 run scoreboard players get #tmp1 skys_horizon.temp
