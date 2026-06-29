# If the "task" crosshair was previously shown, but is gone now, fade it out
execute if entity @s[tag=!skys_horizon.crosshair.task, tag=skys_horizon.crosshair.task.active] run return run function {
    tag @s remove skys_horizon.crosshair.task.active
    title @s times 0 0 10t
    function skys_horizon:crosshair/crosshairs/task
}

execute if entity @s[tag=skys_horizon.crosshair.task, tag=!skys_horizon.crosshair.task.active] run return run function {
    tag @s add skys_horizon.crosshair.task.active
    title @s times 10t 2t 0
    function skys_horizon:crosshair/crosshairs/task
}

execute if entity @s[tag=skys_horizon.crosshair.task, tag=skys_horizon.crosshair.task.active] run return run function {
    title @s times 0 2t 0
    function skys_horizon:crosshair/crosshairs/task
}

function skys_horizon:crosshair/apply { type: "default" }
