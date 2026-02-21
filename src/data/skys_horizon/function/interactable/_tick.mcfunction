effect clear @e[tag=skys_horizon.interactable] glowing
execute as @a at @s run tag @e[tag=skys_horizon.interactable, distance=..5] add find_looking.candidate
execute as @a at @s run function find_looking:find
execute as @e[tag=skys_horizon.interactable, tag=find_looking.result, distance=..5, limit=1] run function skys_horizon:interactable/main
