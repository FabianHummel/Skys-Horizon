scoreboard players operation $progress skys_horizon.crosshair = @s skys_horizon.interactable.progress
execute store result score $duration skys_horizon.crosshair run data get entity @s SelectedItem.components."minecraft:custom_data"."skys_horizon:interactable".duration
execute if entity @s[tag=skys_horizon.crosshair.can_progress] if score @s skys_horizon.interactable.progress_direction > @s skys_horizon.interactable.prev_progress_direction run function skys_horizon:crosshair/show { type: "progress_increasing" }

execute if score @s skys_horizon.interactable.progress >= $duration skys_horizon.crosshair run function skys_horizon:interactable/on_interaction with entity @s SelectedItem.components."minecraft:custom_data"."skys_horizon:interactable"

execute if entity @s[tag=skys_horizon.crosshair.can_progress] if score @s skys_horizon.interactable.progress_direction matches -1 if score @s skys_horizon.interactable.progress matches 0 run function skys_horizon:crosshair/show { type: "task_open" }

execute if entity @s[tag=skys_horizon.crosshair.can_progress, tag=!skys_horizon.crosshair.prev_can_progress, scores={skys_horizon.interactable.progress_direction=1..}] run function skys_horizon:crosshair/show { type: "progress_increasing" }

scoreboard players operation $progress skys_horizon.crosshair = $duration skys_horizon.crosshair
scoreboard players operation $progress skys_horizon.crosshair -= @s skys_horizon.interactable.progress
scoreboard players operation $progress skys_horizon.crosshair *= #-1 skys_horizon.const
execute if entity @s[tag=skys_horizon.crosshair.can_progress] if score @s skys_horizon.interactable.progress_direction < @s skys_horizon.interactable.prev_progress_direction run function skys_horizon:crosshair/show { type: "progress_decreasing" }

scoreboard players operation @s skys_horizon.interactable.prev_progress_direction = @s skys_horizon.interactable.progress_direction
scoreboard players operation @s skys_horizon.interactable.progress += @s skys_horizon.interactable.progress_direction
scoreboard players operation @s skys_horizon.interactable.progress > #0 skys_horizon.const

execute store result score @s skys_horizon.interactable.progress_direction run data get entity @s SelectedItem.components."minecraft:custom_data"."skys_horizon:interactable".cancel
