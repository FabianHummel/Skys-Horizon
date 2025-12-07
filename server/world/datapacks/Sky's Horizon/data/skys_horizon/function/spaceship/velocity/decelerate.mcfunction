scoreboard players operation #tmp1 skys_horizon.temp = @s skys_horizon.spaceship.velocity

# Increase deceleration force when braking
execute if predicate skys_horizon:spaceship/velocity/braking run scoreboard players operation #tmp1 skys_horizon.temp *= #brake_multiplier skys_horizon.spaceship.const

# Apply gradual deceleration (percentage of current velocity)
scoreboard players operation #tmp1 skys_horizon.temp /= #deceleration_scale skys_horizon.spaceship.const
scoreboard players operation #tmp1 skys_horizon.temp -= #1 skys_horizon.const
scoreboard players operation @s skys_horizon.spaceship.velocity += #tmp1 skys_horizon.temp

# Override FOV adjustment during deceleration
scoreboard players operation #tmp1 skys_horizon.temp *= #deceleration_fov_multiplier skys_horizon.spaceship.const