execute if predicate skys_horizon:spaceship/steering_left unless score @s skys_horizon.spaceship.steering matches ..-10 run scoreboard players remove @s skys_horizon.spaceship.steering 2
execute if predicate skys_horizon:spaceship/steering_right unless score @s skys_horizon.spaceship.steering matches 10.. run scoreboard players add @s skys_horizon.spaceship.steering 2
execute unless predicate skys_horizon:spaceship/steering_left unless predicate skys_horizon:spaceship/steering_right run function skys_horizon:spaceship/steering_center
execute store result entity @e[tag=skys_horizon.spaceship.model,limit=1,sort=nearest] transformation.right_rotation[2] double 0.01 run scoreboard players get @s skys_horizon.spaceship.steering

execute store result storage skys_horizon spaceship.rotation_to_add double 0.05 run scoreboard players get @s skys_horizon.spaceship.steering
execute as @e[tag=skys_horizon.spaceship.model,limit=1,sort=nearest] at @s run function skys_horizon:spaceship/apply_rotation with storage skys_horizon spaceship
function skys_horizon:spaceship/apply_rotation with storage skys_horizon spaceship

scoreboard players operation #tmp1 skys_horizon.temp = @s skys_horizon.spaceship.velocity
scoreboard players operation #tmp1 skys_horizon.temp -= #max_realistic_velocity skys_horizon.spaceship.const
execute if score #tmp1 skys_horizon.temp matches -100.. run scoreboard players set #tmp1 skys_horizon.temp -100
execute store result entity @e[tag=skys_horizon.spaceship.model,limit=1,sort=nearest] transformation.right_rotation[3] double -0.01 run scoreboard players get #tmp1 skys_horizon.temp