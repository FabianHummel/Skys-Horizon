advancement revoke @s only skys_horizon:interactable/use_item
execute store result score @s skys_horizon.interactable.progress_direction run data get entity @s SelectedItem.components."minecraft:custom_data"."skys_horizon:interactable".increase
