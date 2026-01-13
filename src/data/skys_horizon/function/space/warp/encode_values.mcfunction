# Encode roll and opacity values in a vec3 (for use in dye color):
#           ₂₄   ₂₀   ₁₆   ₁₂   ₈    ₄    ₀
# vec3 bits: 0000.0000.0000.0000.0000.0000
#           |---red---||-green-||--blue---|
#           |--------roll------||-opacity-|

# Map 0.00-360.00 to 0-65536: ⌊angle * 2¹⁶ / 360°⌋
scoreboard players operation #tmp1 skys_horizon.temp = @p skys_horizon.space.roll
scoreboard players operation #tmp1 skys_horizon.temp *= #65536 skys_horizon.const
scoreboard players operation #tmp1 skys_horizon.temp /= #36000 skys_horizon.const

# Red: (value >> 8) << 16
scoreboard players operation #tmp2 skys_horizon.temp = #tmp1 skys_horizon.temp
scoreboard players operation #tmp2 skys_horizon.temp /= #256 skys_horizon.const
scoreboard players operation #tmp2 skys_horizon.temp *= #65536 skys_horizon.const
scoreboard players operation #out skys_horizon.temp = #tmp2 skys_horizon.temp

# Green (low 4 bits): (value % 2⁴) << 8
scoreboard players operation #tmp2 skys_horizon.temp = #tmp1 skys_horizon.temp
scoreboard players operation #tmp2 skys_horizon.temp %= #16 skys_horizon.const
scoreboard players operation #tmp2 skys_horizon.temp *= #256 skys_horizon.const
scoreboard players operation #out skys_horizon.temp += #tmp2 skys_horizon.temp

# Blue: Take opacity (0-255) as-is
scoreboard players operation #out skys_horizon.temp += @p skys_horizon.space.warp

execute store result entity @s item.components."minecraft:dyed_color" int 1 run scoreboard players get #out skys_horizon.temp
