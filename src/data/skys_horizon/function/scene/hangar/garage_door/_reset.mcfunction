kill @e[type=minecraft:falling_block,tag=skys_horizon.scene.hangar.garage_door]
fill 71 1 -1 88 9 -1 minecraft:barrier replace minecraft:air
scoreboard players reset $scene.hangar.garage_door skys_horizon.counter
schedule clear skys_horizon:scene/hangar/garage_door/open

fill 71 1 -2 88 9 -2 minecraft:command_block{Command:"execute align xyz run summon falling_block ~.5 ~.05 ~.5 {BlockState:{Name:'minecraft:purpur_pillar',Properties:{axis:'x'}},Tags:['skys_horizon.scene.hangar.garage_door'],NoGravity:1b,Time:-2147483648}", auto:1b}

function callback_scheduler:schedule {\
    ticks: 2,\
    selector: "@s",\
    command: "fill 71 1 -2 88 9 -2 minecraft:air"\
}
