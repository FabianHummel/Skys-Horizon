scoreboard players operation @s skys_horizon.crosshair.prev_task_direction = @s skys_horizon.crosshair.task_direction
scoreboard players set @s skys_horizon.crosshair.task_direction -1
execute if entity @s[tag=skys_horizon.crosshair.task] run scoreboard players set @s skys_horizon.crosshair.task_direction 1

scoreboard players operation @s skys_horizon.crosshair.task += @s skys_horizon.crosshair.task_direction
scoreboard players operation @s skys_horizon.crosshair.task > #-1 skys_horizon.const
scoreboard players set @s[scores={skys_horizon.crosshair.task=5..}] skys_horizon.crosshair.task 5

execute if score @s skys_horizon.crosshair.task_direction > @s skys_horizon.crosshair.prev_task_direction run function skys_horizon:crosshair/apply { type: "task_opening" }
execute if score @s skys_horizon.crosshair.task_direction < @s skys_horizon.crosshair.prev_task_direction run function skys_horizon:crosshair/apply { type: "task_closing" }
execute if score @s skys_horizon.crosshair.task_direction matches 1 if score @s skys_horizon.crosshair.task matches 4 run function skys_horizon:crosshair/apply { type: "task_open" }
execute if score @s skys_horizon.crosshair.task_direction matches -1 if score @s skys_horizon.crosshair.task matches 0 run function skys_horizon:crosshair/apply { type: "default" }
