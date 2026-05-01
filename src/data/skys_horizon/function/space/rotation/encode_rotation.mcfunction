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
execute store result score $rotation_color_precise skys_horizon.space run data get storage skys_horizon temp.index
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

# Make sure we default to one in case it's zero.
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
execute store result score $rotation_color_rough skys_horizon.space run data get storage skys_horizon temp.index
scoreboard players operation $rotation_color_rough skys_horizon.space *= #2^21 skys_horizon.const

# Map ±√(2)÷2 → 0-128, shift by 14 bits and add to color
execute store result score #tmp1 skys_horizon.temp run data get storage skys_horizon temp.rotation[0] 90
scoreboard players add #tmp1 skys_horizon.temp 64
scoreboard players operation #tmp1 skys_horizon.temp *= #2^14 skys_horizon.const
scoreboard players operation $rotation_color_rough skys_horizon.space += #tmp1 skys_horizon.temp

# Map ±√(2)÷2 → 0-128, shift by 7 bits and add to color
execute store result score #tmp1 skys_horizon.temp run data get storage skys_horizon temp.rotation[1] 90
scoreboard players add #tmp1 skys_horizon.temp 64
scoreboard players operation #tmp1 skys_horizon.temp *= #2^7 skys_horizon.const
scoreboard players operation $rotation_color_rough skys_horizon.space += #tmp1 skys_horizon.temp

# Map ±√(2)÷2 → 0-128 and add to color
execute store result score #tmp1 skys_horizon.temp run data get storage skys_horizon temp.rotation[2] 90
scoreboard players add #tmp1 skys_horizon.temp 64
scoreboard players operation $rotation_color_rough skys_horizon.space += #tmp1 skys_horizon.temp

# Make sure we default to one in case it's zero.
scoreboard players operation $rotation_color_rough skys_horizon.space > #1 skys_horizon.const
