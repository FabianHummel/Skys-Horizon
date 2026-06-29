# Disable all general player interactions in adventure mode
attribute @s[gamemode=!adventure] minecraft:block_interaction_range base reset
attribute @s[gamemode=adventure] minecraft:block_interaction_range base set 0

execute if predicate skys_horizon:interactable/is_holding_interactable_item run function skys_horizon:interactable/holding_interactable_item

tag @e[distance=..4, tag=skys_horizon.interactable] add find_looking.candidate
function find_looking:find
tag @n[distance=..4, tag=skys_horizon.interactable, tag=find_looking.result] add skys_horizon.interactable.active
execute if entity @n[distance=..4, tag=skys_horizon.interactable, tag=find_looking.result] run tag @s add skys_horizon.crosshair.task

execute store result score #tmp1 skys_horizon.temp run data get entity @s SelectedItemSlot
execute unless score #tmp1 skys_horizon.temp = @s skys_horizon.interactable.selected_item_slot run scoreboard players set @s skys_horizon.interactable.progress 0
scoreboard players operation @s skys_horizon.interactable.selected_item_slot = #tmp1 skys_horizon.temp

# Reset the progress when not looking at interactable entity
scoreboard players set @s[tag=!skys_horizon.crosshair.task] skys_horizon.interactable.progress 0
