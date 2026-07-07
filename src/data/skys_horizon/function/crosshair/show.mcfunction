scoreboard players operation #in skys_horizon.temp = $progress skys_horizon.crosshair
scoreboard players operation #in skys_horizon.temp *= #1.000 skys_horizon.const
scoreboard players operation #in skys_horizon.temp /= $duration skys_horizon.crosshair
scoreboard players operation #in skys_horizon.temp += #1.000 skys_horizon.const
function skys_horizon:utility/int_to_color

$function skys_horizon:crosshair/crosshairs/$(type) with storage skys_horizon temp
