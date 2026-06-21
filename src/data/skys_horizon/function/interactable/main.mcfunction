$tag @e[distance=..$(interaction_range), tag=skys_horizon.interactable] add find_looking.candidate
function find_looking:find
tag @s add skys_horizon.crosshair.task_cancel
$execute as @n[distance=..$(interaction_range), tag=skys_horizon.interactable, tag=find_looking.result] run function skys_horizon:interactable/main_interactable
