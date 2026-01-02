# Map two values (pitch and roll) to a vec3 (dye color):
#
#           ₂₄   ₂₀   ₁₆   ₁₂   ₈    ₄    ₀
# vec3 bits: 0000.0000.0000.0000.0000.0000
#           |---red---||-green--||--blue--|
#           |----pitch-----||----roll-----|

# Map 0.00-360.00 to 0-4096: ⌊angle * 2¹² / 360°⌋
scoreboard players operation #tmp1 skys_horizon.temp = @s skys_horizon.space.pitch
scoreboard players operation #tmp1 skys_horizon.temp *= #4096 skys_horizon.const
scoreboard players operation #tmp1 skys_horizon.temp /= #36000 skys_horizon.const

# Red (8 bits): (value >> 4) << 16
scoreboard players operation #tmp2 skys_horizon.temp = #tmp1 skys_horizon.temp
scoreboard players operation #tmp2 skys_horizon.temp /= #16 skys_horizon.const
scoreboard players operation #tmp2 skys_horizon.temp *= #65536 skys_horizon.const
scoreboard players operation #out skys_horizon.temp = #tmp2 skys_horizon.temp

# Green (low 4 bits): (value % 2⁴) << 12
scoreboard players operation #tmp2 skys_horizon.temp = #tmp1 skys_horizon.temp
scoreboard players operation #tmp2 skys_horizon.temp %= #16 skys_horizon.const
scoreboard players operation #tmp2 skys_horizon.temp *= #4096 skys_horizon.const
scoreboard players operation #out skys_horizon.temp += #tmp2 skys_horizon.temp

# Map 0.00-360.00 to 0-4096: ⌊angle * 2¹² / 360°⌋
scoreboard players operation #tmp1 skys_horizon.temp = @s skys_horizon.space.roll
scoreboard players operation #tmp1 skys_horizon.temp *= #4096 skys_horizon.const
scoreboard players operation #tmp1 skys_horizon.temp /= #36000 skys_horizon.const

# Green (high 4 bits): (value >> 8) << 8
scoreboard players operation #tmp2 skys_horizon.temp = #tmp1 skys_horizon.temp
scoreboard players operation #tmp2 skys_horizon.temp /= #256 skys_horizon.const
scoreboard players operation #tmp2 skys_horizon.temp *= #256 skys_horizon.const
scoreboard players operation #out skys_horizon.temp += #tmp2 skys_horizon.temp

# Blue (8 bits): (value % 2⁴) << 0
scoreboard players operation #tmp2 skys_horizon.temp = #tmp1 skys_horizon.temp
scoreboard players operation #tmp2 skys_horizon.temp %= #256 skys_horizon.const
scoreboard players operation #out skys_horizon.temp += #tmp2 skys_horizon.temp
