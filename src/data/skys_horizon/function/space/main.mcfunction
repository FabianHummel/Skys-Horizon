# Reduce FOV
attribute @s minecraft:movement_speed base set 0.02

# Mount spaceship
ride @s mount @n[type=item_display,tag=skys_horizon.spaceship.model]

# Update celestial objects
execute as @e[x=0,type=minecraft:item_display,tag=skys_horizon.space.planet] run function skys_horizon:space/planet/main
execute as @e[x=0,type=minecraft:item_display,tag=skys_horizon.space.skybox] run function skys_horizon:space/skybox/main
execute as @e[x=0,type=minecraft:item_display,tag=skys_horizon.space.warp] run function skys_horizon:space/warp/main

title @s actionbar ["Rotation: ", {storage:"skys_horizon",nbt:"space.rotation"}]

# Calculate products of individual quaternion components.
#> x × x
data modify storage skys_horizon temp.x set from storage skys_horizon space.rotation[0]
function gm:square with storage skys_horizon temp
data modify storage skys_horizon temp.xx set from storage gm:io out

#> x × y
data modify storage skys_horizon temp.y set from storage skys_horizon space.rotation[1]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.xy set from storage gm:io out

#> x × z
data modify storage skys_horizon temp.y set from storage skys_horizon space.rotation[2]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.xz set from storage gm:io out

#> x × w
data modify storage skys_horizon temp.y set from storage skys_horizon space.rotation[3]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.xw set from storage gm:io out

#> y × y
data modify storage skys_horizon temp.x set from storage skys_horizon space.rotation[1]
function gm:square with storage skys_horizon temp
data modify storage skys_horizon temp.yy set from storage gm:io out

#> y × z
data modify storage skys_horizon temp.y set from storage skys_horizon space.rotation[2]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.yz set from storage gm:io out

#> y × w
data modify storage skys_horizon temp.y set from storage skys_horizon space.rotation[3]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.yw set from storage gm:io out

#> z × z
data modify storage skys_horizon temp.x set from storage skys_horizon space.rotation[2]
function gm:square with storage skys_horizon temp
data modify storage skys_horizon temp.zz set from storage gm:io out

#> z × w
data modify storage skys_horizon temp.y set from storage skys_horizon space.rotation[3]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.zw set from storage gm:io out

# Construct 3x3 matrix from current rotation.
data modify storage skys_horizon temp.mat3 set value [0f,0f,0f,0f,0f,0f,0f,0f,0f]

#> 1 - 2 × (yy + zz)
data modify storage skys_horizon temp.x set from storage skys_horizon temp.yy
data modify storage skys_horizon temp.y set from storage skys_horizon temp.zz
function gm:add with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
data modify storage skys_horizon temp.y set value 2.0f
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.x set value 1.0f
data modify storage skys_horizon temp.y set from storage gm:io out
function gm:subtract with storage skys_horizon temp
data modify storage skys_horizon temp.mat3[0] set from storage gm:io out

#> 2 × (xy - zw)
data modify storage skys_horizon temp.x set from storage skys_horizon temp.xy
data modify storage skys_horizon temp.y set from storage skys_horizon temp.zw
function gm:subtract with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
data modify storage skys_horizon temp.y set value 2.0f
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.mat3[1] set from storage gm:io out

#> 2 × (xz + yw)
data modify storage skys_horizon temp.x set from storage skys_horizon temp.xz
data modify storage skys_horizon temp.y set from storage skys_horizon temp.yw
function gm:add with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
data modify storage skys_horizon temp.y set value 2.0f
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.mat3[2] set from storage gm:io out

#> 2 × (xy + zw)
data modify storage skys_horizon temp.x set from storage skys_horizon temp.xy
data modify storage skys_horizon temp.y set from storage skys_horizon temp.zw
function gm:add with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
data modify storage skys_horizon temp.y set value 2.0f
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.mat3[3] set from storage gm:io out

#> 1 - 2 × (xx + zz)
data modify storage skys_horizon temp.x set from storage skys_horizon temp.xx
data modify storage skys_horizon temp.y set from storage skys_horizon temp.zz
function gm:add with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
data modify storage skys_horizon temp.y set value 2.0f
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.x set value 1.0f
data modify storage skys_horizon temp.y set from storage gm:io out
function gm:subtract with storage skys_horizon temp
data modify storage skys_horizon temp.mat3[4] set from storage gm:io out

#> 2 × (yz - xw)
data modify storage skys_horizon temp.x set from storage skys_horizon temp.yz
data modify storage skys_horizon temp.y set from storage skys_horizon temp.xw
function gm:subtract with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
data modify storage skys_horizon temp.y set value 2.0f
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.mat3[5] set from storage gm:io out

#> 2 × (xz - yw)
data modify storage skys_horizon temp.x set from storage skys_horizon temp.xz
data modify storage skys_horizon temp.y set from storage skys_horizon temp.yw
function gm:subtract with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
data modify storage skys_horizon temp.y set value 2.0f
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.mat3[6] set from storage gm:io out

#> 2 × (yz + xw)
data modify storage skys_horizon temp.x set from storage skys_horizon temp.yz
data modify storage skys_horizon temp.y set from storage skys_horizon temp.xw
function gm:add with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
data modify storage skys_horizon temp.y set value 2.0f
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.mat3[7] set from storage gm:io out

#> 1 - 2 × (xx + yy)
data modify storage skys_horizon temp.x set from storage skys_horizon temp.xx
data modify storage skys_horizon temp.y set from storage skys_horizon temp.yy
function gm:add with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
data modify storage skys_horizon temp.y set value 2.0f
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.x set value 1.0f
data modify storage skys_horizon temp.y set from storage gm:io out
function gm:subtract with storage skys_horizon temp
data modify storage skys_horizon temp.mat3[8] set from storage gm:io out

# Scale matrix components by angular velocities
execute store result storage skys_horizon temp.x float 0.0001 run scoreboard players get @s skys_horizon.spaceship.pitch_velocity

data modify storage skys_horizon temp.y set from storage skys_horizon temp.mat3[0]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.mat3[0] set from storage gm:io out

data modify storage skys_horizon temp.y set from storage skys_horizon temp.mat3[1]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.mat3[1] set from storage gm:io out

data modify storage skys_horizon temp.y set from storage skys_horizon temp.mat3[2]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.mat3[2] set from storage gm:io out

execute store result storage skys_horizon temp.x float 0.0001 run scoreboard players get @s skys_horizon.spaceship.yaw_velocity

data modify storage skys_horizon temp.y set from storage skys_horizon temp.mat3[3]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.mat3[3] set from storage gm:io out

data modify storage skys_horizon temp.y set from storage skys_horizon temp.mat3[4]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.mat3[4] set from storage gm:io out

data modify storage skys_horizon temp.y set from storage skys_horizon temp.mat3[5]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.mat3[5] set from storage gm:io out

execute store result storage skys_horizon temp.x float 0.0001 run scoreboard players get @s skys_horizon.spaceship.roll_velocity

data modify storage skys_horizon temp.y set from storage skys_horizon temp.mat3[6]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.mat3[6] set from storage gm:io out

data modify storage skys_horizon temp.y set from storage skys_horizon temp.mat3[7]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.mat3[7] set from storage gm:io out

data modify storage skys_horizon temp.y set from storage skys_horizon temp.mat3[8]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.mat3[8] set from storage gm:io out

# Calculate final directional vector
data modify storage skys_horizon temp.omega set value [0f,0f,0f]

#> Local right axis
execute in minecraft:overworld run item modify block 29999999 0 91665 container.0 {function:set_custom_model_data,floats:{mode:replace_all,values:[{type:sum,summands:[{type:storage,storage:"skys_horizon",path:"temp.mat3[0]"},{type:storage,storage:"skys_horizon",path:"temp.mat3[3]"},{type:storage,storage:"skys_horizon",path:"temp.mat3[6]"}]}]}}
execute in minecraft:overworld run data modify storage skys_horizon temp.omega[0] set from block 29999999 0 91665 Items[0].components."minecraft:custom_model_data".floats[0]

#> Local up axis
execute in minecraft:overworld run item modify block 29999999 0 91665 container.0 {function:set_custom_model_data,floats:{mode:replace_all,values:[{type:sum,summands:[{type:storage,storage:"skys_horizon",path:"temp.mat3[1]"},{type:storage,storage:"skys_horizon",path:"temp.mat3[4]"},{type:storage,storage:"skys_horizon",path:"temp.mat3[7]"}]}]}}
execute in minecraft:overworld run data modify storage skys_horizon temp.omega[1] set from block 29999999 0 91665 Items[0].components."minecraft:custom_model_data".floats[0]

#> Local forward axis
execute in minecraft:overworld run item modify block 29999999 0 91665 container.0 {function:set_custom_model_data,floats:{mode:replace_all,values:[{type:sum,summands:[{type:storage,storage:"skys_horizon",path:"temp.mat3[2]"},{type:storage,storage:"skys_horizon",path:"temp.mat3[5]"},{type:storage,storage:"skys_horizon",path:"temp.mat3[8]"}]}]}}
execute in minecraft:overworld run data modify storage skys_horizon temp.omega[2] set from block 29999999 0 91665 Items[0].components."minecraft:custom_model_data".floats[0]

# Calculate length of the vector
data modify storage skys_horizon temp.x set from storage skys_horizon temp.omega[0]
data modify storage skys_horizon temp.y set from storage skys_horizon temp.omega[1]
data modify storage skys_horizon temp.z set from storage skys_horizon temp.omega[2]
function gm:zzz/distance_handling with storage skys_horizon temp
data modify storage skys_horizon temp.y set from storage gm:io out

# Normalize the vector
data modify storage skys_horizon temp.x set from storage skys_horizon temp.omega
function gm:divide with storage skys_horizon temp
data modify storage skys_horizon temp.omega set from storage gm:io out

# Rotate angle about an axis
#> α = length ÷ 2
data modify storage skys_horizon temp.x set from storage skys_horizon temp.y
data modify storage skys_horizon temp.y set value 2f
function gm:divide with storage skys_horizon temp
data modify storage skys_horizon temp.alpha set from storage gm:io out

#> Approximate sin(α) with Taylor series (third order): sin(α) ≅ α - α³ ÷ 3!
data modify storage skys_horizon temp.x set from storage skys_horizon temp.alpha
function gm:square with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
data modify storage skys_horizon temp.y set from storage skys_horizon temp.alpha
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
data modify storage skys_horizon temp.y set value 6f
function gm:divide with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage skys_horizon temp.alpha
data modify storage skys_horizon temp.y set from storage gm:io out
function gm:subtract with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out

#> Multiply with omega
data modify storage skys_horizon temp.y set from storage skys_horizon temp.omega[0]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.omega[0] set from storage gm:io out

data modify storage skys_horizon temp.y set from storage skys_horizon temp.omega[1]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.omega[1] set from storage gm:io out

data modify storage skys_horizon temp.y set from storage skys_horizon temp.omega[2]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.omega[2] set from storage gm:io out

#> Approximate cos(α) with Taylor series (fourth order): cos(α) ≅ 1 - α² ÷ 2! + α⁴ ÷ 4!
data modify storage skys_horizon temp.x set from storage skys_horizon temp.alpha
function gm:square with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
data modify storage skys_horizon temp.alpha_squared set from storage gm:io out
data modify storage skys_horizon temp.y set value 2f
function gm:divide with storage skys_horizon temp
data modify storage skys_horizon temp.temp.x set from storage gm:io out
data modify storage skys_horizon temp.x set from storage skys_horizon temp.alpha_squared
function gm:square with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
data modify storage skys_horizon temp.y set value 24f
function gm:divide with storage skys_horizon temp
data modify storage skys_horizon temp.temp.y set from storage gm:io out
function gm:add with storage skys_horizon temp.temp
data modify storage skys_horizon temp.y set from storage gm:io out
data modify storage skys_horizon temp.x set value 1f
function gm:subtract with storage skys_horizon temp
data modify storage skys_horizon temp.omega append from storage gm:io out

# Multiply the updated quaternion onto the current rotation using the Hamilton product
data modify storage skys_horizon temp.summands set value []

#> x = a.w * b.x + a.x * b.w + a.y * b.z - a.z * b.y
data modify storage skys_horizon temp.x set from storage skys_horizon space.rotation[3]
data modify storage skys_horizon temp.y set from storage skys_horizon temp.omega[0]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.summands append from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon space.rotation[0]
data modify storage skys_horizon temp.y set from storage skys_horizon temp.omega[3]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.summands append from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon space.rotation[1]
data modify storage skys_horizon temp.y set from storage skys_horizon temp.omega[2]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.summands append from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon space.rotation[2]
data modify storage skys_horizon temp.y set from storage skys_horizon temp.omega[1]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
function gm:negate with storage skys_horizon temp
data modify storage skys_horizon temp.summands append from storage gm:io out

#> y = a.w * b.y - a.x * b.z + a.y * b.w + a.z * b.x
data modify storage skys_horizon temp.x set from storage skys_horizon space.rotation[3]
data modify storage skys_horizon temp.y set from storage skys_horizon temp.omega[1]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.summands append from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon space.rotation[0]
data modify storage skys_horizon temp.y set from storage skys_horizon temp.omega[2]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
function gm:negate with storage skys_horizon temp
data modify storage skys_horizon temp.summands append from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon space.rotation[1]
data modify storage skys_horizon temp.y set from storage skys_horizon temp.omega[3]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.summands append from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon space.rotation[2]
data modify storage skys_horizon temp.y set from storage skys_horizon temp.omega[0]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.summands append from storage gm:io out

#> z = a.w * b.z + a.x * b.y - a.y * b.x + a.z * b.w
data modify storage skys_horizon temp.x set from storage skys_horizon space.rotation[3]
data modify storage skys_horizon temp.y set from storage skys_horizon temp.omega[2]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.summands append from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon space.rotation[0]
data modify storage skys_horizon temp.y set from storage skys_horizon temp.omega[1]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.summands append from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon space.rotation[1]
data modify storage skys_horizon temp.y set from storage skys_horizon temp.omega[0]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
function gm:negate with storage skys_horizon temp
data modify storage skys_horizon temp.summands append from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon space.rotation[2]
data modify storage skys_horizon temp.y set from storage skys_horizon temp.omega[3]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.summands append from storage gm:io out

#> w = a.w * b.w - a.x * b.x - a.y * b.y - a.z * b.z
data modify storage skys_horizon temp.x set from storage skys_horizon space.rotation[3]
data modify storage skys_horizon temp.y set from storage skys_horizon temp.omega[3]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.summands append from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon space.rotation[0]
data modify storage skys_horizon temp.y set from storage skys_horizon temp.omega[0]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
function gm:negate with storage skys_horizon temp
data modify storage skys_horizon temp.summands append from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon space.rotation[1]
data modify storage skys_horizon temp.y set from storage skys_horizon temp.omega[1]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
function gm:negate with storage skys_horizon temp
data modify storage skys_horizon temp.summands append from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon space.rotation[2]
data modify storage skys_horizon temp.y set from storage skys_horizon temp.omega[2]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
function gm:negate with storage skys_horizon temp
data modify storage skys_horizon temp.summands append from storage gm:io out

execute in minecraft:overworld run item modify block 29999999 0 91665 container.0 {function:set_custom_model_data,floats:{mode:replace_all,values:[{type:sum,summands:[{type:storage,storage:"skys_horizon",path:"temp.summands[0]"},{type:storage,storage:"skys_horizon",path:"temp.summands[1]"},{type:storage,storage:"skys_horizon",path:"temp.summands[2]"},{type:storage,storage:"skys_horizon",path:"temp.summands[3]"}]}]}}
execute in minecraft:overworld run data modify storage skys_horizon space.rotation[0] set from block 29999999 0 91665 Items[0].components."minecraft:custom_model_data".floats[0]

execute in minecraft:overworld run item modify block 29999999 0 91665 container.0 {function:set_custom_model_data,floats:{mode:replace_all,values:[{type:sum,summands:[{type:storage,storage:"skys_horizon",path:"temp.summands[4]"},{type:storage,storage:"skys_horizon",path:"temp.summands[5]"},{type:storage,storage:"skys_horizon",path:"temp.summands[6]"},{type:storage,storage:"skys_horizon",path:"temp.summands[7]"}]}]}}
execute in minecraft:overworld run data modify storage skys_horizon space.rotation[1] set from block 29999999 0 91665 Items[0].components."minecraft:custom_model_data".floats[0]

execute in minecraft:overworld run item modify block 29999999 0 91665 container.0 {function:set_custom_model_data,floats:{mode:replace_all,values:[{type:sum,summands:[{type:storage,storage:"skys_horizon",path:"temp.summands[8]"},{type:storage,storage:"skys_horizon",path:"temp.summands[9]"},{type:storage,storage:"skys_horizon",path:"temp.summands[10]"},{type:storage,storage:"skys_horizon",path:"temp.summands[11]"}]}]}}
execute in minecraft:overworld run data modify storage skys_horizon space.rotation[2] set from block 29999999 0 91665 Items[0].components."minecraft:custom_model_data".floats[0]

execute in minecraft:overworld run item modify block 29999999 0 91665 container.0 {function:set_custom_model_data,floats:{mode:replace_all,values:[{type:sum,summands:[{type:storage,storage:"skys_horizon",path:"temp.summands[12]"},{type:storage,storage:"skys_horizon",path:"temp.summands[13]"},{type:storage,storage:"skys_horizon",path:"temp.summands[14]"},{type:storage,storage:"skys_horizon",path:"temp.summands[15]"}]}]}}
execute in minecraft:overworld run data modify storage skys_horizon space.rotation[3] set from block 29999999 0 91665 Items[0].components."minecraft:custom_model_data".floats[0]

# Normalize final quaternion
#> √(x² + y² + z² + w²)
data modify storage skys_horizon temp.x set from storage skys_horizon space.rotation[0]
data modify storage skys_horizon temp.y set from storage skys_horizon space.rotation[1]
data modify storage skys_horizon temp.z set from storage skys_horizon space.rotation[2]
function gm:zzz/distance_handling with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
data modify storage skys_horizon temp.y set from storage skys_horizon space.rotation[3]
data modify storage skys_horizon temp.z set value 0f
function gm:zzz/distance_handling with storage skys_horizon temp
data modify storage skys_horizon temp.y set from storage gm:io out

# Divide components through length
data modify storage skys_horizon temp.x set from storage skys_horizon space.rotation[0]
function gm:divide with storage skys_horizon temp
data modify storage skys_horizon space.rotation[0] set from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon space.rotation[1]
function gm:divide with storage skys_horizon temp
data modify storage skys_horizon space.rotation[1] set from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon space.rotation[2]
function gm:divide with storage skys_horizon temp
data modify storage skys_horizon space.rotation[2] set from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon space.rotation[3]
function gm:divide with storage skys_horizon temp
data modify storage skys_horizon space.rotation[3] set from storage gm:io out

# Find the highest absolute number of the four components and remove it
data modify storage skys_horizon temp.rotation set from storage skys_horizon space.rotation
scoreboard players set #test skys_horizon.temp 0
function skys_horizon:space/rotation/check_greater {index: 0}
function skys_horizon:space/rotation/check_greater {index: 1}
function skys_horizon:space/rotation/check_greater {index: 2}
function skys_horizon:space/rotation/check_greater {index: 3}
function skys_horizon:space/rotation/remove_component with storage skys_horizon temp

# Flip all components if the largest one is negative to ensure it's positive
execute if score #flipped skys_horizon.temp matches 1 run function skys_horizon:space/rotation/flip_rotation

# Encode values in a combination of yaw and a 24 bit color (precise)
#       ₂₄      ₂₀      ₁₆      ₁₂      ₈       ₄      ₀
# bits: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
#       |i| |----component 1----| |----component 2----|
#       |-----red-----| |----green----| |-----blue----|

# Left shift by 22 bits and add to color
scoreboard players operation $rotation_color_precise skys_horizon.space = #index skys_horizon.temp
scoreboard players operation $rotation_color_precise skys_horizon.space *= #2^22 skys_horizon.const

# Map ±√(2)÷2 → 0-2048, shift by 11 bits and add to color
execute store result score #tmp1 skys_horizon.temp run data get storage skys_horizon temp.rotation[0] 1448
scoreboard players add #tmp1 skys_horizon.temp 1024
scoreboard players operation #tmp1 skys_horizon.temp *= #2^11 skys_horizon.const
scoreboard players operation $rotation_color_precise skys_horizon.space += #tmp1 skys_horizon.temp

# Map ±√(2)÷2 → 0-2048 and add to color
execute store result score #tmp1 skys_horizon.temp run data get storage skys_horizon temp.rotation[1] 1448
scoreboard players add #tmp1 skys_horizon.temp 1024
scoreboard players operation $rotation_color_precise skys_horizon.space += #tmp1 skys_horizon.temp

# Make sure we don't use 0, so we default to 1.
scoreboard players operation $rotation_color_precise skys_horizon.space > #1 skys_horizon.const

# Map ±√(2)÷2 → 0-360.000 and provide for later use in yaw rotation
execute store result score $rotation_yaw skys_horizon.space run data get storage skys_horizon temp.rotation[2] 254558
scoreboard players add $rotation_yaw skys_horizon.space 180000

# Encode values in a 24 bit color (rough)
#  one bit is wasted here :(
#       ₂₄      ₂₀      ₁₆      ₁₂      ₈       ₄      ₀
# bits: 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
#       - |i| |--cmpnt 1--| |--cmpnt 2--| |--cmpnt 3--|
#       |-----red-----| |----green----| |-----blue----|

# Left shift by 22 bits and add to color
scoreboard players operation $rotation_color_rough skys_horizon.space = #index skys_horizon.temp
scoreboard players operation $rotation_color_rough skys_horizon.space *= #2^21 skys_horizon.const

# Map ±√(2)÷2 → 0-128, shift by 14 bits and add to color
execute store result score #tmp1 skys_horizon.temp run data get storage skys_horizon temp.rotation[0] 90
scoreboard players add #tmp1 skys_horizon.temp 90
scoreboard players operation #tmp1 skys_horizon.temp *= #2^14 skys_horizon.const
scoreboard players operation $rotation_color_rough skys_horizon.space += #tmp1 skys_horizon.temp

# Map ±√(2)÷2 → 0-128, shift by 7 bits and add to color
execute store result score #tmp1 skys_horizon.temp run data get storage skys_horizon temp.rotation[1] 90
scoreboard players add #tmp1 skys_horizon.temp 90
scoreboard players operation #tmp1 skys_horizon.temp *= #2^7 skys_horizon.const
scoreboard players operation $rotation_color_rough skys_horizon.space += #tmp1 skys_horizon.temp

# Map ±√(2)÷2 → 0-128 and add to color
execute store result score #tmp1 skys_horizon.temp run data get storage skys_horizon temp.rotation[2] 90
scoreboard players add #tmp1 skys_horizon.temp 90
scoreboard players operation $rotation_color_rough skys_horizon.space += #tmp1 skys_horizon.temp

# Make sure we don't use 0, so we default to 1.
scoreboard players operation $rotation_color_rough skys_horizon.space > #1 skys_horizon.const
