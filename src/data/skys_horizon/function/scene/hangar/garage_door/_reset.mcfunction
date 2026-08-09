kill @e[type=minecraft:falling_block,tag=skys_horizon.scene.hangar.garage_door]
fill 71 1 -1 88 9 -1 minecraft:barrier replace minecraft:air
scoreboard players reset $scene.hangar.garage_door skys_horizon.counter
schedule clear skys_horizon:scene/hangar/garage_door/open_loop
stopsound @a block skys_horizon:hangar.garage_door

fill 71 1 -2 88 9 -2 minecraft:air

fill 71 1 -2 88 9 -2 minecraft:command_block{\
    Command: "function skys_horizon:scene/hangar/garage_door/spawn_block",\
    auto: true\
}
