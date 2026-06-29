scoreboard players operation @s skys_horizon.interactable.progress += @s skys_horizon.interactable.progress_direction
scoreboard players operation @s skys_horizon.interactable.progress > #0 skys_horizon.const
execute store result score @s skys_horizon.interactable.progress_direction run data get entity @s SelectedItem.components."minecraft:custom_data"."skys_horizon:interactable".cancel
