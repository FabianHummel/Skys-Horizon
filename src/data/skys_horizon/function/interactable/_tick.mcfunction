# Check for interactable entities
tag @e[tag=skys_horizon.interactable] remove skys_horizon.interactable.active
tag @e[tag=skys_horizon.interactable] remove find_looking.candidate
execute as @a at @s run function skys_horizon:interactable/main

# Make entity appear glowing when being looked at.
execute as @e[tag=skys_horizon.interactable] store result entity @s Glowing byte 1 if entity @s[tag=skys_horizon.interactable.active]
