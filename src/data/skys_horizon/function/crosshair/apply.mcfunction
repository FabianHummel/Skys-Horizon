# # Calculate progress: elapsed / duration
# # if duration is 0 -> progress = 100%
# execute store result score #tmp1 skys_horizon.temp run time query gametime
# scoreboard players operation #tmp1 skys_horizon.temp -= #time skys_horizon.crosshair
# execute store result score #time skys_horizon.crosshair run time query gametime
# scoreboard players operation #tmp1 skys_horizon.temp *= #1.000 skys_horizon.const
# scoreboard players operation #tmp1 skys_horizon.temp /= @s skys_horizon.crosshair.duration
# execute if score @s skys_horizon.crosshair.duration matches 0 run scoreboard players set #tmp1 skys_horizon.temp 1000

# # Calculate new offset: min(100% - progress - old offset, 0%)
# scoreboard players set #in skys_horizon.temp 1000
# scoreboard players operation #in skys_horizon.temp -= #tmp1 skys_horizon.temp
# scoreboard players operation #in skys_horizon.temp -= $offset skys_horizon.crosshair
# scoreboard players operation #in skys_horizon.temp > #0 skys_horizon.const
# scoreboard players operation $offset skys_horizon.crosshair = #in skys_horizon.temp
# function skys_horizon:utility/int_to_color
$function skys_horizon:crosshair/crosshairs/$(type) with storage skys_horizon temp
