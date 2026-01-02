# Update rotation
rotate @s 180 0
scoreboard players add @s skys_horizon.space.roll 50
function skys_horizon:space/clamp_rotation

function skys_horizon:space/planet/encode_color
execute as @e[x=0,type=minecraft:item_display,tag=skys_horizon.space.planet] run function skys_horizon:space/planet/update
execute as @e[x=0,type=minecraft:item_display,tag=skys_horizon.space.skybox] run function skys_horizon:space/skybox/update
