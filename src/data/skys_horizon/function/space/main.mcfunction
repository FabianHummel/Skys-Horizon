# Reduce FOV
attribute @s minecraft:movement_speed base set 0.02

# Mount spaceship
ride @s mount @n[type=item_display,tag=skys_horizon.spaceship.model]

# Update celestial objects
execute as @e[x=0,type=minecraft:item_display,tag=skys_horizon.space.planet] run function skys_horizon:space/planet/main
execute as @e[x=0,type=minecraft:item_display,tag=skys_horizon.space.skybox] run function skys_horizon:space/skybox/main
execute as @e[x=0,type=minecraft:item_display,tag=skys_horizon.space.warp] run function skys_horizon:space/warp/main

title @s actionbar ["Rotation: ", {storage:"skys_horizon",nbt:"space.rotation"}]

# q *= axis_angle(vec3(0, 0, 1), rollInput);
function skys_horizon:space/rotation/axis_angle { axis: 2, input: "roll" }
function skys_horizon:space/rotation/multiply_quaternion

# q *= axis_angle(vec3(0, 1, 0), deltaX);
function skys_horizon:space/rotation/axis_angle { axis: 1, input: "yaw" }
function skys_horizon:space/rotation/multiply_quaternion

# q *= axis_angle(vec3(1, 0, 0), deltaY);
function skys_horizon:space/rotation/axis_angle { axis: 0, input: "pitch" }
function skys_horizon:space/rotation/multiply_quaternion

function skys_horizon:space/rotation/normalize_quaternion
function skys_horizon:space/rotation/encode_rotation
