# Reduce FOV
attribute @s minecraft:movement_speed base set 0.02

# Mount spaceship
ride @s mount @n[type=item_display,tag=skys_horizon.spaceship.model]

# Update celestial objects
execute as @e[x=0,type=minecraft:item_display,tag=skys_horizon.space.planet] run function skys_horizon:space/planet/main
execute as @e[x=0,type=minecraft:item_display,tag=skys_horizon.space.skybox] run function skys_horizon:space/skybox/main
execute as @e[x=0,type=minecraft:item_display,tag=skys_horizon.space.warp] run function skys_horizon:space/warp/main

title @s actionbar {storage:"skys_horizon",nbt:"space.rotation"}

# Calculate products of individual quaternion components.
# x × x
data modify storage skys_horizon temp.x set from storage skys_horizon space.rotation[0]
function gm:square with storage skys_horizon temp
data modify storage skys_horizon temp.xx set from storage gm:io out

# x × y
data modify storage skys_horizon temp.y set from storage skys_horizon space.rotation[1]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.xy set from storage gm:io out

# x × z
data modify storage skys_horizon temp.y set from storage skys_horizon space.rotation[2]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.xz set from storage gm:io out

# x × w
data modify storage skys_horizon temp.y set from storage skys_horizon space.rotation[3]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.xw set from storage gm:io out

# y × y
data modify storage skys_horizon temp.x set from storage skys_horizon space.rotation[1]
function gm:square with storage skys_horizon temp
data modify storage skys_horizon temp.yy set from storage gm:io out

# y × z
data modify storage skys_horizon temp.y set from storage skys_horizon space.rotation[2]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.yz set from storage gm:io out

# y × w
data modify storage skys_horizon temp.y set from storage skys_horizon space.rotation[3]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.yw set from storage gm:io out

# z × z
data modify storage skys_horizon temp.x set from storage skys_horizon space.rotation[2]
function gm:square with storage skys_horizon temp
data modify storage skys_horizon temp.zz set from storage gm:io out

# z × w
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

execute store result score #tmp1 skys_horizon.temp run data get storage minecraft:skys_horizon temp.y 100000
execute if score #tmp1 skys_horizon.temp matches ..0 run return fail

# Normalize the vector
data modify storage skys_horizon temp.x set from storage skys_horizon temp.omega
function gm:divide with storage skys_horizon temp
data modify storage skys_horizon temp.omega set from storage gm:io out

# Rotate angle about an axis
#> α = length ÷ 2
data modify storage skys_horizon temp.x set from storage skys_horizon temp.y
data modify storage skys_horizon temp.y set value 2f
function gm:divide with storage skys_horizon temp
data modify storage skys_horizon temp.tmp1 set from storage gm:io out

#> Calculate sin(α) with Taylor Series (first degree): sin(α) ≅ α - α³ ÷ 3!
data modify storage skys_horizon temp.x set from storage skys_horizon temp.tmp1
function gm:square with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
data modify storage skys_horizon temp.y set from storage skys_horizon temp.tmp1
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
data modify storage skys_horizon temp.y set value 6f
function gm:divide with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage skys_horizon temp.tmp1
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
