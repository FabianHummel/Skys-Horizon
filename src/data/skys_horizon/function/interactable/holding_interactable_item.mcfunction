scoreboard players operation $progress skys_horizon.crosshair = @s skys_horizon.interactable.progress
execute store result score $duration skys_horizon.crosshair run data get entity @s SelectedItem.components."minecraft:custom_data"."skys_horizon:interactable".duration
execute if score @s skys_horizon.interactable.progress_direction > @s skys_horizon.interactable.prev_progress_direction run function skys_horizon:crosshair/show { type: "progress_increasing" }

scoreboard players operation $progress skys_horizon.crosshair = $duration skys_horizon.crosshair
scoreboard players operation $progress skys_horizon.crosshair -= @s skys_horizon.interactable.progress
scoreboard players operation $progress skys_horizon.crosshair *= #-1 skys_horizon.const
execute if score @s skys_horizon.interactable.progress_direction < @s skys_horizon.interactable.prev_progress_direction run function skys_horizon:crosshair/show { type: "progress_decreasing" }

scoreboard players operation @s skys_horizon.interactable.prev_progress_direction = @s skys_horizon.interactable.progress_direction
scoreboard players operation @s skys_horizon.interactable.progress += @s skys_horizon.interactable.progress_direction
scoreboard players operation @s skys_horizon.interactable.progress > #0 skys_horizon.const

execute if score @s skys_horizon.interactable.progress >= $duration skys_horizon.crosshair run function skys_horizon:interactable/on_interaction with entity @s SelectedItem.components."minecraft:custom_data"."skys_horizon:interactable"

execute store result score @s skys_horizon.interactable.progress_direction run data get entity @s SelectedItem.components."minecraft:custom_data"."skys_horizon:interactable".cancel
