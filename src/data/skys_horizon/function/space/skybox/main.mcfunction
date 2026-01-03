scoreboard players operation @s skys_horizon.space.warp_time += @s skys_horizon.space.warp_intensity

function skys_horizon:space/skybox/encode_color
execute as @e[x=0,type=minecraft:item_display,tag=skys_horizon.space.skybox] run function skys_horizon:space/skybox/update
