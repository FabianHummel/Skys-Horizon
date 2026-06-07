data modify storage skys_horizon temp.min_x set from entity @s data.min[0]
data modify storage skys_horizon temp.min_y set from entity @s data.min[1]
data modify storage skys_horizon temp.min_z set from entity @s data.min[2]
data modify storage skys_horizon temp.max_x set from entity @s data.max[0]
data modify storage skys_horizon temp.max_y set from entity @s data.max[1]
data modify storage skys_horizon temp.max_z set from entity @s data.max[2]

execute unless data entity @s data.uuid run function skys_horizon:scene/location_check/stringify_uuid

data modify storage skys_horizon temp.on_enter set from entity @s data.on_enter
data modify storage skys_horizon temp.on_exit set from entity @s data.on_exit
data modify storage skys_horizon temp.uuid set from entity @s data.uuid

execute as @a at @s run function skys_horizon:scene/location_check/main with storage skys_horizon temp
