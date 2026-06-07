$execute if predicate {condition:"minecraft:location_check",predicate:{position:{x:{min:$(min_x),max:$(max_x)},y:{min:$(min_y),max:$(max_y)},z:{min:$(min_z),max:$(max_z)}}}} run return run function skys_horizon:scene/location_check/in_area with storage skys_horizon temp
execute if data storage skys_horizon temp.on_exit run function skys_horizon:scene/location_check/outside_area with storage skys_horizon temp
$tag @s remove skys_horizon.scene.location_check.$(uuid)
