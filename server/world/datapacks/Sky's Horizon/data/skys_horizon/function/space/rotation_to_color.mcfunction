# angle / 360.0 * 4096.0
scoreboard players operation #tmp1 skys_horizon.temp = @s skys_horizon.space.pitch
scoreboard players operation #tmp1 skys_horizon.temp *= #4096 skys_horizon.const
scoreboard players operation #tmp1 skys_horizon.temp /= #36000 skys_horizon.const

# 4 high bits (red): ⌊value / 2⁸⌋ * 2²⁰
scoreboard players operation #tmp2 skys_horizon.temp = #tmp1 skys_horizon.temp
scoreboard players operation #tmp2 skys_horizon.temp /= #256 skys_horizon.const
scoreboard players operation #tmp2 skys_horizon.temp *= #1048576 skys_horizon.const
scoreboard players operation #out skys_horizon.temp = #tmp2 skys_horizon.temp

# 8 low bits (green): value % 2⁸ * 2⁸
scoreboard players operation #tmp2 skys_horizon.temp = #tmp1 skys_horizon.temp
scoreboard players operation #tmp2 skys_horizon.temp %= #256 skys_horizon.const
scoreboard players operation #tmp2 skys_horizon.temp *= #256 skys_horizon.const
scoreboard players operation #out skys_horizon.temp += #tmp2 skys_horizon.temp

# angle / 360.0 * 4096.0
scoreboard players operation #tmp1 skys_horizon.temp = @s skys_horizon.space.roll
scoreboard players operation #tmp1 skys_horizon.temp *= #4096 skys_horizon.const
scoreboard players operation #tmp1 skys_horizon.temp /= #36000 skys_horizon.const

# 4 low bits (red): ⌊value / 2⁸⌋ * 2¹⁶
scoreboard players operation #tmp2 skys_horizon.temp = #tmp1 skys_horizon.temp
scoreboard players operation #tmp2 skys_horizon.temp /= #256 skys_horizon.const
scoreboard players operation #tmp2 skys_horizon.temp *= #65536 skys_horizon.const
scoreboard players operation #out skys_horizon.temp += #tmp2 skys_horizon.temp

# 8 low bits (blue): value % 2⁸
scoreboard players operation #tmp2 skys_horizon.temp = #tmp1 skys_horizon.temp
scoreboard players operation #tmp2 skys_horizon.temp %= #256 skys_horizon.const
scoreboard players operation #out skys_horizon.temp += #tmp2 skys_horizon.temp
