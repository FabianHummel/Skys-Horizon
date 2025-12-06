execute if predicate skys_horizon:spaceship/accelerating if score @s skys_horizon.spaceship.velocity matches ..500 run function skys_horizon:spaceship/accelerate_start
execute if predicate skys_horizon:spaceship/accelerating if score @s skys_horizon.spaceship.velocity matches 501.. run function skys_horizon:spaceship/accelerate_end
scoreboard players operation #tmp1 skys_horizon.temp = @s skys_horizon.spaceship.velocity
scoreboard players operation #tmp1 skys_horizon.temp /= #acceleration_fov_multiplier skys_horizon.spaceship.const
execute if predicate skys_horizon:spaceship/decelerating run function skys_horizon:spaceship/decelerate
execute store result storage skys_horizon spaceship.player_fov_multiplier double 0.005 run scoreboard players get #tmp1 skys_horizon.temp
function skys_horizon:spaceship/apply_fov with storage skys_horizon spaceship
# Clamp velocity to a minimum of 0
execute if score @s skys_horizon.spaceship.velocity matches ..-1 run scoreboard players set @s skys_horizon.spaceship.velocity 0