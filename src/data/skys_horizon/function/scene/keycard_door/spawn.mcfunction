function skys_horizon:scene/keycard_door/zzz/spawn_marker
execute as @n[type=minecraft:marker, tag=skys_horizon.scene.keycard_door.marker] run function gu:generate
data modify storage skys_horizon temp.marker_uuid set from storage gu:main out
$data modify storage skys_horizon temp.key set value "$(key)"
function skys_horizon:scene/keycard_door/zzz/spawn_keycard_reader with storage skys_horizon temp
