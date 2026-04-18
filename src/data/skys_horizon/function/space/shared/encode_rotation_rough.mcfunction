# Encode all three euler angles in a vec3 (for use in dye color):
#           ₂₄   ₂₀   ₁₆   ₁₂   ₈    ₄    ₀
# vec3 bits: 0000.0000.0000.0000.0000.0000
#           |---red---||-green--||--blue--|
#           |---yaw---||-pitch--||--roll--|

# Map 0.00-360.00 to 0-256: ⌊yaw * 2⁸ / 360°⌋
scoreboard players operation #tmp1 skys_horizon.temp = @p skys_horizon.space.yaw
scoreboard players operation #tmp1 skys_horizon.temp *= #256 skys_horizon.const
scoreboard players operation #tmp1 skys_horizon.temp /= #360000 skys_horizon.const

# Red (8 bits): value << 16
scoreboard players operation #tmp1 skys_horizon.temp *= #65536 skys_horizon.const
scoreboard players operation #out skys_horizon.temp = #tmp1 skys_horizon.temp

# Map 0.00-360.00 to 0-256: ⌊pitch * 2⁸ / 360°⌋
scoreboard players operation #tmp1 skys_horizon.temp = @p skys_horizon.space.pitch
scoreboard players operation #tmp1 skys_horizon.temp *= #256 skys_horizon.const
scoreboard players operation #tmp1 skys_horizon.temp /= #360000 skys_horizon.const

# Green (8 bits): value << 8
scoreboard players operation #tmp1 skys_horizon.temp *= #256 skys_horizon.const
scoreboard players operation #out skys_horizon.temp += #tmp1 skys_horizon.temp

# Map 0.00-360.00 to 0-256: ⌊roll * 2⁸ / 360°⌋
scoreboard players operation #tmp1 skys_horizon.temp = @p skys_horizon.space.roll
scoreboard players operation #tmp1 skys_horizon.temp *= #256 skys_horizon.const
scoreboard players operation #tmp1 skys_horizon.temp /= #360000 skys_horizon.const

# Blue (8 bits): value << 0
scoreboard players operation #out skys_horizon.temp += #tmp1 skys_horizon.temp

# Make sure we don't use 0, so we default to 1.
scoreboard players operation #out skys_horizon.temp > #1 skys_horizon.const

# Store the final value in the "dyed_color" item component to be used within the shader
execute store result entity @s item.components."minecraft:dyed_color" int 1 run scoreboard players get #out skys_horizon.temp
