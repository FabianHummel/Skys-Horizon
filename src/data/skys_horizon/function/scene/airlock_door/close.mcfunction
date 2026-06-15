$tag $(deactivate_region) remove skys_horizon.scene.location_check.active
$execute as $(selector) if entity @s[tag=!skys_horizon.scene.airlock_door.closed] run function skys_horizon:scene/airlock_door/animations/close/play
