tag @e[tag=skys_horizon.interactable] remove skys_horizon.interactable.active
execute as @a at @s run function skys_horizon:interactable/prepare
execute as @e[tag=skys_horizon.interactable] store result entity @s Glowing byte 1 if entity @s[tag=skys_horizon.interactable.active]
