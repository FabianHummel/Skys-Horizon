# Reduce FOV
attribute @s minecraft:movement_speed base set 0.02

# Update celestial objects
execute as @e[x=0,type=minecraft:item_display,tag=skys_horizon.space.planet] run function skys_horizon:space/planet/main
execute as @e[x=0,type=minecraft:item_display,tag=skys_horizon.space.skybox] run function skys_horizon:space/skybox/main
execute as @e[x=0,type=minecraft:item_display,tag=skys_horizon.space.warp] run function skys_horizon:space/warp/main

# Update angles based on input velocities
scoreboard players operation @s skys_horizon.space.yaw -= @s skys_horizon.spaceship.yaw_velocity
scoreboard players operation @s skys_horizon.space.pitch -= @s skys_horizon.spaceship.pitch_velocity
scoreboard players operation @s skys_horizon.space.roll -= @s skys_horizon.spaceship.roll_velocity

# Clamp rotation to wrap around 360°
function skys_horizon:space/clamp_rotation
