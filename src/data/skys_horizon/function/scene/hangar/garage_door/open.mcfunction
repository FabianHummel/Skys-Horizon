execute store result storage skys_horizon temp.frame int 1 run scoreboard players get $scene.hangar.garage_door skys_horizon.counter
function skys_horizon:scene/hangar/garage_door/apply_motion with storage skys_horizon temp
scoreboard players add $scene.hangar.garage_door skys_horizon.counter 1
schedule function skys_horizon:scene/hangar/garage_door/open 20t replace
fill 71 1 -1 88 9 -1 minecraft:air replace minecraft:barrier
