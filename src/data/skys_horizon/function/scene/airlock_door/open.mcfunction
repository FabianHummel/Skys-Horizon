$tag $(activate_region) add skys_horizon.scene.location_check.active
$execute as $(selector) if entity @s[tag=!skys_horizon.scene.airlock_door.open] run function skys_horizon:scene/airlock_door/animations/open/play
$function callback_scheduler:schedule {\
    ticks: 200,\
    selector: "@s",\
    command: "function skys_horizon:scene/airlock_door/close { selector: '$(selector)', deactivate_region: '$(activate_region)' }"\
}
