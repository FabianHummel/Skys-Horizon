$execute as $(uuid) if entity @s[tag=!skys_horizon.scene.airlock_door.open] run function skys_horizon:scene/airlock_door/animations/open/play
$execute as $(uuid) at @s run function callback_scheduler:schedule { ticks: 200, selector: "@s", command: "execute if entity @s[tag=!skys_horizon.scene.airlock_door.closed] run function skys_horizon:scene/airlock_door/animations/close/play"}
