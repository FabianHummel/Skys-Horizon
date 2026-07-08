scoreboard players set @s skys_horizon.interactable.progress 0
scoreboard players operation $progress skys_horizon.crosshair = @s skys_horizon.interactable.progress
function skys_horizon:crosshair/show { type: "progress_increasing" }
$$(command)
