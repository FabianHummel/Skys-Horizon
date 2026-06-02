execute store result storage skys_horizon temp.frame int 1 run scoreboard players get @s skys_horizon.counter
$function $(place_function) with storage skys_horizon temp
scoreboard players add @s skys_horizon.counter 1
$scoreboard players set @s[scores={skys_horizon.counter=$(absolute_end)..}] skys_horizon.counter $(start_offset)
$function callback_scheduler:schedule {\
    ticks: $(frame_duration),\
    selector: "@s",\
    command: 'function skys_horizon:scene/animation_step {\
        place_function: \\"$(place_function)\\",\
        start_offset: $(start_offset),\
        absolute_end: $(absolute_end),\
        frame_duration: $(frame_duration)\
    }'\
}
