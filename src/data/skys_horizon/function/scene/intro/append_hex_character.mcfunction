execute store result storage skys_horizon temp.in int 1 run scoreboard players get #tmp1 skys_horizon.temp
function skys_horizon:utility/int_to_hex with storage skys_horizon temp
$data modify storage skys_horizon temp.tmp$(digit) set from storage skys_horizon temp.out
