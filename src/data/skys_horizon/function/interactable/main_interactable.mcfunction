tag @s add skys_horizon.interactable.active
tag @p add skys_horizon.crosshair.task
execute if data entity @s data.interaction_duration run return run function skys_horizon:interactable/main_interactable_task
