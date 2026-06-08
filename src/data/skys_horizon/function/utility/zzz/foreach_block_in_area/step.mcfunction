$$(command)

scoreboard players remove #tmp1 skys_horizon.temp 1
$execute if score #tmp1 skys_horizon.temp matches 0.. positioned ~1 ~ ~ run return run function skys_horizon:utility/zzz/foreach_block_in_area/step {\
    dx: $(dx), dy: $(dy), dz: $(dz), command: "$(command)"\
}

scoreboard players remove #tmp2 skys_horizon.temp 1
$scoreboard players set #tmp1 skys_horizon.temp $(dx)
$execute if score #tmp2 skys_horizon.temp matches 0.. positioned ~-$(dx) ~1 ~ run return run function skys_horizon:utility/zzz/foreach_block_in_area/step {\
    dx: $(dx), dy: $(dy), dz: $(dz), command: "$(command)"\
}

scoreboard players remove #tmp3 skys_horizon.temp 1
$scoreboard players set #tmp2 skys_horizon.temp $(dy)
$execute if score #tmp3 skys_horizon.temp matches 0.. positioned ~-$(dx) ~-$(dy) ~1 run return run function skys_horizon:utility/zzz/foreach_block_in_area/step {\
    dx: $(dx), dy: $(dy), dz: $(dz), command: "$(command)"\
}

kill @s
