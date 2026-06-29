advancement revoke @s only skys_horizon:interactable/use_item
execute store result score @s skys_horizon.interactable.progress_direction run data get entity @s SelectedItem.components."minecraft:custom_data"."skys_horizon:interactable".increase
execute store result score #tmp1 skys_horizon.temp run data get entity @s SelectedItem.components."minecraft:custom_data"."skys_horizon:interactable".duration
execute if score @s skys_horizon.interactable.progress >= #tmp1 skys_horizon.temp run function skys_horizon:interactable/on_interaction with entity @s SelectedItem.components."minecraft:custom_data"."skys_horizon:interactable"
