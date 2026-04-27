# Reduce FOV
attribute @s minecraft:movement_speed base set 0.02

# Update celestial objects
execute as @e[x=0,type=minecraft:item_display,tag=skys_horizon.space.planet] run function skys_horizon:space/planet/main
execute as @e[x=0,type=minecraft:item_display,tag=skys_horizon.space.skybox] run function skys_horizon:space/skybox/main
execute as @e[x=0,type=minecraft:item_display,tag=skys_horizon.space.warp] run function skys_horizon:space/warp/main

title @s actionbar {storage:"skys_horizon",nbt:"space.rotation"}
