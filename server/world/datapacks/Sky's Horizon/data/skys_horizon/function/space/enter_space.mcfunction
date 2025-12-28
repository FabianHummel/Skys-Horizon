# Add apppropriate tag
tag @s add skys_horizon.player.in_space

# Spawn space sky
execute unless entity @e[type=minecraft:item_display,tag=skys_horizon.celestial.background,limit=1,x=0] run summon item_display ~ ~ ~ {Tags:["skys_horizon.celestial.space_sky"],item_display:"none",transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[-100f,-100f,-100f]},item:{id:"minecraft:leather_horse_armor",count:1,components:{"minecraft:dyed_color":16742912,"minecraft:item_model":"skys_horizon:celestial/space_sky"}}}

# Make player invisible
effect give @s minecraft:invisibility infinite 1 true
