$execute unless score $$(frame_duration) skys_horizon.timer matches 0 run return fail
execute store result storage skys_horizon temp.frame int 1 run scoreboard players get @s skys_horizon.counter
$function $(place_function) with storage skys_horizon temp
scoreboard players add @s skys_horizon.counter 1
$scoreboard players set @s[scores={skys_horizon.counter=$(absolute_end)..}] skys_horizon.counter $(start_offset)
