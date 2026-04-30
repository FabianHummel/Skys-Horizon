$execute store result score #tmp1 skys_horizon.temp run data get storage skys_horizon temp.rotation[$(index)] 1000000000
scoreboard players operation #tmp2 skys_horizon.temp = #tmp1 skys_horizon.temp
execute if score #tmp2 skys_horizon.temp matches ..-1 run scoreboard players operation #tmp2 skys_horizon.temp *= #-1 skys_horizon.const
execute if score #tmp2 skys_horizon.temp < #test skys_horizon.temp run return fail
$data modify storage skys_horizon temp.index set value $(index)
scoreboard players operation #test skys_horizon.temp = #tmp2 skys_horizon.temp
execute store success score #flipped skys_horizon.temp if score #tmp1 skys_horizon.temp matches ..-1
