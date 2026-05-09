# Update horizontal player rotation
rotate @s[y_rotation=17..180] 17 ~
rotate @s[y_rotation=-180..-17] -17 ~
execute store result storage skys_horizon temp.in float -0.0003 run data get entity @s Rotation[0] 1000
execute store result score @s skys_horizon.spaceship.yaw_velocity run data get storage skys_horizon temp.in -100
execute rotated as @s run function skys_horizon:spaceship/space/apply_horizontal_rotation with storage skys_horizon temp

# Update vertical player rotation
execute store result storage skys_horizon temp.in float -0.0003 run data get entity @s Rotation[1] 1000
execute store result score @s skys_horizon.spaceship.pitch_velocity run data get storage skys_horizon temp.in -40
execute rotated as @s run function skys_horizon:spaceship/space/apply_vertical_rotation with storage skys_horizon temp

# Update roll velocity based on player input
execute if predicate skys_horizon:spaceship/steering/steering_left run scoreboard players operation @s skys_horizon.spaceship.roll_velocity -= #roll_acceleration skys_horizon.spaceship.const
execute if predicate skys_horizon:spaceship/steering/steering_right run scoreboard players operation @s skys_horizon.spaceship.roll_velocity += #roll_acceleration skys_horizon.spaceship.const

# Decelerate roll velocity when no input
execute unless predicate skys_horizon:spaceship/steering/steering_right if score @s skys_horizon.spaceship.roll_velocity matches 0.. run function skys_horizon:spaceship/space/decelerate_roll
execute unless predicate skys_horizon:spaceship/steering/steering_left if score @s skys_horizon.spaceship.roll_velocity matches ..0 run function skys_horizon:spaceship/space/decelerate_roll

# Clamp roll velocity
scoreboard players operation @s skys_horizon.spaceship.roll_velocity < #max_roll_velocity skys_horizon.spaceship.const
scoreboard players operation @s skys_horizon.spaceship.roll_velocity > #min_roll_velocity skys_horizon.spaceship.const
