# Second phase acceleration: gradually reduce velocity to zero over end_phase_duration
scoreboard players operation #tmp2 skys_horizon.temp = @s skys_horizon.spaceship.velocity
scoreboard players operation #tmp2 skys_horizon.temp -= #acceleration_end_phase skys_horizon.spaceship.const
scoreboard players operation #tmp2 skys_horizon.temp /= #acceleration_scale skys_horizon.spaceship.const
scoreboard players operation #tmp1 skys_horizon.temp = #end_phase_duration skys_horizon.spaceship.const
scoreboard players operation #tmp1 skys_horizon.temp /= #tmp2 skys_horizon.temp
scoreboard players operation @s skys_horizon.spaceship.velocity += #tmp1 skys_horizon.temp