execute as @e[tag=skys_horizon.scene.hangar.industrial_fan.3x3] at @s run function skys_horizon:scene/animation_step {\
    place_function: "skys_horizon:scene/hangar/industrial_fan/place_3x3",\
    start_offset: 2,\
    absolute_end: 6,\
    frame_duration: 4\
}
