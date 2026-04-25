$execute store result storage skys_horizon temp.tmp1 float $(length) run scoreboard players get #omega.x skys_horizon.temp
$execute store result score #omega.x skys_horizon.temp run data get skys_horizon temp.tmp1 $(sin)

$execute store result storage skys_horizon temp.tmp1 float $(length) run scoreboard players get #omega.y skys_horizon.temp
$execute store result score #omega.y skys_horizon.temp run data get skys_horizon temp.tmp1 $(sin)

$execute store result storage skys_horizon temp.tmp1 float $(length) run scoreboard players get #omega.z skys_horizon.temp
$execute store result score #omega.z skys_horizon.temp run data get skys_horizon temp.tmp1 $(sin)
