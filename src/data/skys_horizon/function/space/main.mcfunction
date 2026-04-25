# Reduce FOV
attribute @s minecraft:movement_speed base set 0.02

# Update celestial objects
execute as @e[x=0,type=minecraft:item_display,tag=skys_horizon.space.planet] run function skys_horizon:space/planet/main
execute as @e[x=0,type=minecraft:item_display,tag=skys_horizon.space.skybox] run function skys_horizon:space/skybox/main
execute as @e[x=0,type=minecraft:item_display,tag=skys_horizon.space.warp] run function skys_horizon:space/warp/main

# Calculate products of individual quaternion components. Scale: ×1.000.000
scoreboard players operation #xx skys_horizon.temp = @s skys_horizon.space.x
scoreboard players operation #xx skys_horizon.temp *= @s skys_horizon.space.x

scoreboard players operation #yy skys_horizon.temp = @s skys_horizon.space.y
scoreboard players operation #yy skys_horizon.temp *= @s skys_horizon.space.y

scoreboard players operation #zz skys_horizon.temp = @s skys_horizon.space.z
scoreboard players operation #zz skys_horizon.temp *= @s skys_horizon.space.z

scoreboard players operation #xy skys_horizon.temp = @s skys_horizon.space.x
scoreboard players operation #xy skys_horizon.temp *= @s skys_horizon.space.y

scoreboard players operation #xz skys_horizon.temp = @s skys_horizon.space.x
scoreboard players operation #xz skys_horizon.temp *= @s skys_horizon.space.z

scoreboard players operation #yz skys_horizon.temp = @s skys_horizon.space.y
scoreboard players operation #yz skys_horizon.temp *= @s skys_horizon.space.z

scoreboard players operation #wx skys_horizon.temp = @s skys_horizon.space.w
scoreboard players operation #wx skys_horizon.temp *= @s skys_horizon.space.x

scoreboard players operation #wy skys_horizon.temp = @s skys_horizon.space.w
scoreboard players operation #wy skys_horizon.temp *= @s skys_horizon.space.y

scoreboard players operation #wz skys_horizon.temp = @s skys_horizon.space.w
scoreboard players operation #wz skys_horizon.temp *= @s skys_horizon.space.z

# Construct 3x3 matrix from current rotation
# 1 - 2 × (yy + zz)
scoreboard players operation #mat3-0.0 skys_horizon.temp = #1.000.000 skys_horizon.const
scoreboard players operation #tmp1 skys_horizon.temp = #yy skys_horizon.temp
scoreboard players operation #tmp1 skys_horizon.temp += #zz skys_horizon.temp
scoreboard players operation #tmp1 skys_horizon.temp *= #2 skys_horizon.const
scoreboard players operation #mat3-0.0 skys_horizon.temp -= #tmp1 skys_horizon.temp

# 2 × (xy - wz)
scoreboard players operation #mat3-0.1 skys_horizon.temp = #xy skys_horizon.temp
scoreboard players operation #mat3-0.1 skys_horizon.temp -= #wz skys_horizon.temp
scoreboard players operation #mat3-0.1 skys_horizon.temp *= #2 skys_horizon.const

# 2 × (xz + wy)
scoreboard players operation #mat3-0.2 skys_horizon.temp = #xz skys_horizon.temp
scoreboard players operation #mat3-0.2 skys_horizon.temp += #wy skys_horizon.temp
scoreboard players operation #mat3-0.2 skys_horizon.temp *= #2 skys_horizon.const

# 2 × (xy + wz)
scoreboard players operation #mat3-1.0 skys_horizon.temp = #xy skys_horizon.temp
scoreboard players operation #mat3-1.0 skys_horizon.temp += #wz skys_horizon.temp
scoreboard players operation #mat3-1.0 skys_horizon.temp *= #2 skys_horizon.const

# 1 - 2 × (xx + zz)
scoreboard players operation #mat3-1.1 skys_horizon.temp = #1.000.000 skys_horizon.const
scoreboard players operation #tmp1 skys_horizon.temp = #xx skys_horizon.temp
scoreboard players operation #tmp1 skys_horizon.temp += #zz skys_horizon.temp
scoreboard players operation #tmp1 skys_horizon.temp *= #2 skys_horizon.const
scoreboard players operation #mat3-1.1 skys_horizon.temp -= #tmp1 skys_horizon.temp

# 2 × (yz - wx)
scoreboard players operation #mat3-1.2 skys_horizon.temp = #yz skys_horizon.temp
scoreboard players operation #mat3-1.2 skys_horizon.temp -= #wx skys_horizon.temp
scoreboard players operation #mat3-1.2 skys_horizon.temp *= #2 skys_horizon.const

# 2 × (xz - wy)
scoreboard players operation #mat3-2.0 skys_horizon.temp = #xz skys_horizon.temp
scoreboard players operation #mat3-2.0 skys_horizon.temp -= #wy skys_horizon.temp
scoreboard players operation #mat3-2.0 skys_horizon.temp *= #2 skys_horizon.const

# 2 × (yz + wx)
scoreboard players operation #mat3-2.1 skys_horizon.temp = #yz skys_horizon.temp
scoreboard players operation #mat3-2.1 skys_horizon.temp += #wx skys_horizon.temp
scoreboard players operation #mat3-2.1 skys_horizon.temp *= #2 skys_horizon.const

# 1 - 2 × (xx + yy)
scoreboard players operation #mat3-2.2 skys_horizon.temp = #1.000.000 skys_horizon.const
scoreboard players operation #tmp1 skys_horizon.temp = #xx skys_horizon.temp
scoreboard players operation #tmp1 skys_horizon.temp += #yy skys_horizon.temp
scoreboard players operation #tmp1 skys_horizon.temp *= #2 skys_horizon.const
scoreboard players operation #mat3-2.2 skys_horizon.temp -= #tmp1 skys_horizon.temp

# Calculate directional vector for the updated rotation
scoreboard players operation #mat3-0.0 skys_horizon.temp *= @s skys_horizon.spaceship.pitch_velocity
scoreboard players operation #mat3-0.1 skys_horizon.temp *= @s skys_horizon.spaceship.pitch_velocity
scoreboard players operation #mat3-0.2 skys_horizon.temp *= @s skys_horizon.spaceship.pitch_velocity

scoreboard players operation #mat3-1.0 skys_horizon.temp *= @s skys_horizon.spaceship.yaw_velocity
scoreboard players operation #mat3-1.1 skys_horizon.temp *= @s skys_horizon.spaceship.yaw_velocity
scoreboard players operation #mat3-1.2 skys_horizon.temp *= @s skys_horizon.spaceship.yaw_velocity

scoreboard players operation #mat3-2.0 skys_horizon.temp *= @s skys_horizon.spaceship.roll_velocity
scoreboard players operation #mat3-2.1 skys_horizon.temp *= @s skys_horizon.spaceship.roll_velocity
scoreboard players operation #mat3-2.2 skys_horizon.temp *= @s skys_horizon.spaceship.roll_velocity

# Local right axis. Scale (omega.*): ×1.000.000
scoreboard players operation #omega.x skys_horizon.temp = #mat3-0.0 skys_horizon.temp
scoreboard players operation #omega.x skys_horizon.temp += #mat3-1.0 skys_horizon.temp
scoreboard players operation #omega.x skys_horizon.temp += #mat3-2.0 skys_horizon.temp

# Local up axis. Scale (omega.*): ×1.000.000
scoreboard players operation #omega.y skys_horizon.temp = #mat3-0.1 skys_horizon.temp
scoreboard players operation #omega.y skys_horizon.temp += #mat3-1.1 skys_horizon.temp
scoreboard players operation #omega.y skys_horizon.temp += #mat3-2.1 skys_horizon.temp

# Local forward axis. Scale (omega.*): ×1.000.000
scoreboard players operation #omega.z skys_horizon.temp = #mat3-0.2 skys_horizon.temp
scoreboard players operation #omega.z skys_horizon.temp += #mat3-1.2 skys_horizon.temp
scoreboard players operation #omega.z skys_horizon.temp += #mat3-2.2 skys_horizon.temp

# Find length of directional vector. Scale (temp.*): ×1.000
execute store result storage skys_horizon temp.x float 0.001 run scoreboard players get #omega.x skys_horizon.temp
execute store result storage skys_horizon temp.y float 0.001 run scoreboard players get #omega.y skys_horizon.temp
execute store result storage skys_horizon temp.z float 0.001 run scoreboard players get #omega.z skys_horizon.temp
function skys_horizon:space/get_distance with storage skys_horizon temp

# Normalize the vector and scale to correct size. Scale (in): ×0.5, Scale (length): ×1
execute store result storage skys_horizon temp.in int 0.0005 store result storage skys_horizon temp.length float 0.001 run data get entity 0-0-0-0-0 transformation.scale[0]
function skys_horizon:space/get_sin_cos with storage skys_horizon temp
execute store result storage skys_horizon temp.sin float 0.000001 run data get storage skys_horizon temp.out[0]
function skys_horizon:space/normalize_and_scale_omega with storage skys_horizon temp
execute store result score #omega.w skys_horizon.temp run data get storage skys_horizon temp.out[1]

# Mutliply the updated quaternion onto the current rotation (Hamilton product). Scale: ×1.000.000.000
# x = a.w * b.x + a.x * b.w + a.y * b.z - a.z * b.y
scoreboard players operation #quat.x skys_horizon.temp = @s skys_horizon.space.w
scoreboard players operation #quat.x skys_horizon.temp *= #omega.x skys_horizon.temp
scoreboard players operation #tmp1 skys_horizon.temp = @s skys_horizon.space.x
scoreboard players operation #tmp1 skys_horizon.temp *= #omega.w skys_horizon.temp
scoreboard players operation #quat.x skys_horizon.temp += #tmp1 skys_horizon.temp
scoreboard players operation #tmp1 skys_horizon.temp = @s skys_horizon.space.y
scoreboard players operation #tmp1 skys_horizon.temp *= #omega.z skys_horizon.temp
scoreboard players operation #quat.x skys_horizon.temp += #tmp1 skys_horizon.temp
scoreboard players operation #tmp1 skys_horizon.temp = @s skys_horizon.space.z
scoreboard players operation #tmp1 skys_horizon.temp *= #omega.y skys_horizon.temp
scoreboard players operation #quat.x skys_horizon.temp -= #tmp1 skys_horizon.temp
scoreboard players operation #quat.x skys_horizon.temp /= #1.000.000 skys_horizon.const

# y = a.w * b.y - a.x * b.z + a.y * b.w + a.z * b.x
scoreboard players operation #quat.y skys_horizon.temp = @s skys_horizon.space.w
scoreboard players operation #quat.y skys_horizon.temp *= #omega.y skys_horizon.temp
scoreboard players operation #tmp1 skys_horizon.temp = @s skys_horizon.space.x
scoreboard players operation #tmp1 skys_horizon.temp *= #omega.z skys_horizon.temp
scoreboard players operation #quat.y skys_horizon.temp -= #tmp1 skys_horizon.temp
scoreboard players operation #tmp1 skys_horizon.temp = @s skys_horizon.space.y
scoreboard players operation #tmp1 skys_horizon.temp *= #omega.w skys_horizon.temp
scoreboard players operation #quat.y skys_horizon.temp += #tmp1 skys_horizon.temp
scoreboard players operation #tmp1 skys_horizon.temp = @s skys_horizon.space.z
scoreboard players operation #tmp1 skys_horizon.temp *= #omega.x skys_horizon.temp
scoreboard players operation #quat.y skys_horizon.temp += #tmp1 skys_horizon.temp
scoreboard players operation #quat.y skys_horizon.temp /= #1.000.000 skys_horizon.const

# z = a.w * b.z + a.x * b.y - a.y * b.x + a.z * b.w
scoreboard players operation #quat.z skys_horizon.temp = @s skys_horizon.space.w
scoreboard players operation #quat.z skys_horizon.temp *= #omega.z skys_horizon.temp
scoreboard players operation #tmp1 skys_horizon.temp = @s skys_horizon.space.x
scoreboard players operation #tmp1 skys_horizon.temp *= #omega.y skys_horizon.temp
scoreboard players operation #quat.z skys_horizon.temp += #tmp1 skys_horizon.temp
scoreboard players operation #tmp1 skys_horizon.temp = @s skys_horizon.space.y
scoreboard players operation #tmp1 skys_horizon.temp *= #omega.x skys_horizon.temp
scoreboard players operation #quat.z skys_horizon.temp -= #tmp1 skys_horizon.temp
scoreboard players operation #tmp1 skys_horizon.temp = @s skys_horizon.space.z
scoreboard players operation #tmp1 skys_horizon.temp *= #omega.w skys_horizon.temp
scoreboard players operation #quat.z skys_horizon.temp += #tmp1 skys_horizon.temp
scoreboard players operation #quat.z skys_horizon.temp /= #1.000.000 skys_horizon.const

# w = a.w * b.w - a.x * b.x - a.y * b.y - a.z * b.z
scoreboard players operation #quat.w skys_horizon.temp = @s skys_horizon.space.w
scoreboard players operation #quat.w skys_horizon.temp *= #omega.w skys_horizon.temp
scoreboard players operation #tmp1 skys_horizon.temp = @s skys_horizon.space.x
scoreboard players operation #tmp1 skys_horizon.temp *= #omega.x skys_horizon.temp
scoreboard players operation #quat.w skys_horizon.temp -= #tmp1 skys_horizon.temp
scoreboard players operation #tmp1 skys_horizon.temp = @s skys_horizon.space.y
scoreboard players operation #tmp1 skys_horizon.temp *= #omega.y skys_horizon.temp
scoreboard players operation #quat.w skys_horizon.temp -= #tmp1 skys_horizon.temp
scoreboard players operation #tmp1 skys_horizon.temp = @s skys_horizon.space.z
scoreboard players operation #tmp1 skys_horizon.temp *= #omega.z skys_horizon.temp
scoreboard players operation #quat.w skys_horizon.temp -= #tmp1 skys_horizon.temp
scoreboard players operation #quat.w skys_horizon.temp /= #1.000.000 skys_horizon.const

# Normalize final quaternion

# Apply as new rotation
scoreboard players operation @s skys_horizon.space.x = #quat.x skys_horizon.temp
scoreboard players operation @s skys_horizon.space.y = #quat.y skys_horizon.temp
scoreboard players operation @s skys_horizon.space.z = #quat.z skys_horizon.temp
scoreboard players operation @s skys_horizon.space.w = #quat.w skys_horizon.temp
