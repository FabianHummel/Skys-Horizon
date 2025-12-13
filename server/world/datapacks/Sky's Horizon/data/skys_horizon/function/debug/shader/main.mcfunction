scoreboard players enable @a skys_horizon.debug.shader
execute as @a if score @s skys_horizon.debug.shader matches 1 run function skys_horizon:debug/shader/show_debug_info
scoreboard players set @a[scores={skys_horizon.debug.shader=2..}] skys_horizon.debug.shader 0