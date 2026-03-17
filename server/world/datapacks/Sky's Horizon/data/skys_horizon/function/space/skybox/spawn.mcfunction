function skys_horizon:space/skybox/remove
execute at @p run summon item_display ~ ~ ~ {teleport_duration:5,view_range:-1f,item_display:"head",Tags:["skys_horizon.space.skybox"],item:{id:"minecraft:leather_horse_armor",count:1,components:{"minecraft:item_model":"skys_horizon:space/skybox","minecraft:dyed_color":0}}}
