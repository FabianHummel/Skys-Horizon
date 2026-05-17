execute store result score #in skys_horizon.temp run stopwatch query skys_horizon:crosshair/offset 20
function skys_horizon:utility/int_to_color
data modify storage skys_horizon crosshair.offset set from storage skys_horizon temp.out
$function skys_horizon:crosshair/crosshairs/$(type) with storage skys_horizon crosshair
stopwatch restart skys_horizon:crosshair/offset
