# Update velocity during acceleration based on player input
execute if predicate skys_horizon:spaceship/velocity/accelerating if score @s skys_horizon.spaceship.velocity matches ..500 run function skys_horizon:spaceship/velocity/accelerate_start
execute if predicate skys_horizon:spaceship/velocity/accelerating if score @s skys_horizon.spaceship.velocity matches 501.. run function skys_horizon:spaceship/velocity/accelerate_end

# Prepare temporary value for FOV calculation
scoreboard players operation #tmp1 skys_horizon.temp = @s skys_horizon.spaceship.velocity
scoreboard players operation #tmp1 skys_horizon.temp /= #acceleration_fov_multiplier skys_horizon.spaceship.const

# Update velocity during deceleration
execute if predicate skys_horizon:spaceship/velocity/decelerating run function skys_horizon:spaceship/velocity/decelerate

# Clamp velocity to a minimum of 0
execute if score @s skys_horizon.spaceship.velocity matches ..-1 run scoreboard players set @s skys_horizon.spaceship.velocity 0

# Set player field of view based on velocity (and deceleration)
execute store result storage skys_horizon spaceship.player_fov_multiplier double 0.005 run scoreboard players get #tmp1 skys_horizon.temp
function skys_horizon:spaceship/velocity/apply_fov with storage skys_horizon spaceship

# Apply velocity to spaceship movement
execute store result storage skys_horizon spaceship.velocity_in_distance double 0.005 run scoreboard players get @s skys_horizon.spaceship.velocity
execute as @e[tag=skys_horizon.spaceship.base,limit=1,sort=nearest] run function skys_horizon:spaceship/velocity/apply_velocity with storage skys_horizon spaceship