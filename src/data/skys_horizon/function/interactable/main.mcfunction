$tag @e[tag=skys_horizon.interactable, distance=..$(interaction_range)] add find_looking.candidate
function find_looking:find
tag @s add skys_horizon.crosshair.task_cancel
$execute unless entity @e[tag=skys_horizon.interactable, tag=find_looking.result, distance=..$(interaction_range), limit=1] run return fail
tag @s add skys_horizon.crosshair.task
$execute as @e[tag=skys_horizon.interactable, tag=find_looking.result, distance=..$(interaction_range), limit=1] run function skys_horizon:interactable/main_interactable
