$execute as $(selector) if entity @s[tag=!skys_horizon.scene.airlock_door.open] run function skys_horizon:scene/airlock_door/animations/open/play
$execute as $(selector) at @s run function callback_scheduler:schedule { ticks: 200, selector: "@s", command: "function skys_horizon:scene/airlock_door/close { selector: '@s' }"}
