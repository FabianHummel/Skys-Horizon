# angle / 360.0 * 2^16
scoreboard players operation #tmp1 skys_horizon.temp = @s skys_horizon.space.pitch
scoreboard players operation #tmp1 skys_horizon.temp *= #256 skys_horizon.const
scoreboard players operation #tmp1 skys_horizon.temp /= #36000 skys_horizon.const
scoreboard players operation #tmp1 skys_horizon.temp *= #65536 skys_horizon.const
scoreboard players operation #out skys_horizon.temp = #tmp1 skys_horizon.temp

# angle / 360.0 * 2^8
scoreboard players operation #tmp1 skys_horizon.temp = @s skys_horizon.space.yaw
scoreboard players operation #tmp1 skys_horizon.temp *= #256 skys_horizon.const
scoreboard players operation #tmp1 skys_horizon.temp /= #36000 skys_horizon.const
scoreboard players operation #tmp1 skys_horizon.temp *= #256 skys_horizon.const
scoreboard players operation #out skys_horizon.temp += #tmp1 skys_horizon.temp

# angle / 360.0 * 2^0
scoreboard players operation #tmp1 skys_horizon.temp = @s skys_horizon.space.roll
scoreboard players operation #tmp1 skys_horizon.temp *= #256 skys_horizon.const
scoreboard players operation #tmp1 skys_horizon.temp /= #36000 skys_horizon.const
scoreboard players operation #out skys_horizon.temp += #tmp1 skys_horizon.temp
