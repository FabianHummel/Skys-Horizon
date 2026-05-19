execute if entity @s[tag=skys_horizon.crosshair.progress] run return run function skys_horizon:crosshair/apply { type: "progress" }
execute if entity @s[tag=skys_horizon.crosshair.progress_cancel] run return run function skys_horizon:crosshair/apply { type: "progress_cancel" }
execute if entity @s[tag=skys_horizon.crosshair.task] run return run function skys_horizon:crosshair/apply { type: "task" }
execute if entity @s[tag=skys_horizon.crosshair.task_cancel] run return run function skys_horizon:crosshair/apply { type: "task_cancel" }
function skys_horizon:crosshair/apply { type: "default" }
