scoreboard players operation @s skys_horizon.crosshair.task += @s skys_horizon.crosshair.task_direction
scoreboard players operation @s skys_horizon.crosshair.task > #-1 skys_horizon.const
scoreboard players set @s[scores={skys_horizon.crosshair.task=5..}] skys_horizon.crosshair.task 5

tag @s[tag=skys_horizon.crosshair.can_progress] add skys_horizon.crosshair.prev_can_progress
tag @s[tag=!skys_horizon.crosshair.can_progress] remove skys_horizon.crosshair.prev_can_progress
tag @s remove skys_horizon.crosshair.can_progress
tag @s[scores={skys_horizon.crosshair.task=5..}] add skys_horizon.crosshair.can_progress

scoreboard players operation $progress skys_horizon.crosshair = @s skys_horizon.crosshair.task
scoreboard players set $duration skys_horizon.crosshair 4
execute if score @s skys_horizon.crosshair.task_direction > @s skys_horizon.crosshair.prev_task_direction run function skys_horizon:crosshair/show { type: "task_opening" }

scoreboard players operation $progress skys_horizon.crosshair = $duration skys_horizon.crosshair
scoreboard players operation $progress skys_horizon.crosshair -= @s skys_horizon.crosshair.task
scoreboard players operation $progress skys_horizon.crosshair *= #-1 skys_horizon.const
execute if score @s skys_horizon.crosshair.task_direction < @s skys_horizon.crosshair.prev_task_direction run function skys_horizon:crosshair/show { type: "task_closing" }

execute if score @s skys_horizon.crosshair.task_direction matches 1 if score @s skys_horizon.crosshair.task matches 4 run function skys_horizon:crosshair/show { type: "task_open" }

execute if score @s skys_horizon.crosshair.task_direction matches -1 if score @s skys_horizon.crosshair.task matches 0 run function skys_horizon:crosshair/show { type: "default" }

scoreboard players operation @s skys_horizon.crosshair.prev_task_direction = @s skys_horizon.crosshair.task_direction
scoreboard players set @s skys_horizon.crosshair.task_direction -1
execute if entity @s[tag=skys_horizon.crosshair.task] run scoreboard players set @s skys_horizon.crosshair.task_direction 1
