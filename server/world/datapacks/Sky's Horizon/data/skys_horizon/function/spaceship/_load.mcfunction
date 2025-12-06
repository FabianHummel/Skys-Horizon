scoreboard objectives add skys_horizon.spaceship.steering dummy

scoreboard objectives add skys_horizon.spaceship.velocity dummy

scoreboard objectives add skys_horizon.spaceship.const dummy
scoreboard players set #acceleration_scale skys_horizon.spaceship.const 20
scoreboard players set #acceleration_end_phase skys_horizon.spaceship.const 480
scoreboard players set #end_phase_duration skys_horizon.spaceship.const 20
scoreboard players set #acceleration_fov_multiplier skys_horizon.spaceship.const 10
scoreboard players set #deceleration_scale skys_horizon.spaceship.const -300
scoreboard players set #brake_multiplier skys_horizon.spaceship.const 10
scoreboard players set #deceleration_fov_multiplier skys_horizon.spaceship.const 3
scoreboard players set #max_realistic_velocity skys_horizon.spaceship.const 900