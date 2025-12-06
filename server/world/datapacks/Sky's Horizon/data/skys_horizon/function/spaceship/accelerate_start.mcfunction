scoreboard players operation #tmp1 skys_horizon.temp = @s skys_horizon.spaceship.velocity
scoreboard players operation #tmp1 skys_horizon.temp /= #acceleration_scale skys_horizon.spaceship.const
scoreboard players operation #tmp1 skys_horizon.temp += #1 skys_horizon.const
scoreboard players operation @s skys_horizon.spaceship.velocity += #tmp1 skys_horizon.temp