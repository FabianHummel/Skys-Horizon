scoreboard players add @s skys_horizon.counter 1
execute store result storage skys_horizon temp.frame int 1 run scoreboard players get @s skys_horizon.counter
data modify storage skys_horizon temp.animation set from entity @s data.animation
function skys_horizon:scene/mannequin/zzz/apply_next_frame_2 with storage skys_horizon temp
execute if score @s skys_horizon.counter >= #tmp1 skys_horizon.temp run tag @s remove skys_horizon.scene.mannequin.replaying
