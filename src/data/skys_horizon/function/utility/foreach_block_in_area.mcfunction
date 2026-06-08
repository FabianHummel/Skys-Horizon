$scoreboard players set #tmp1 skys_horizon.temp $(dx)
$scoreboard players set #tmp2 skys_horizon.temp $(dy)
$scoreboard players set #tmp3 skys_horizon.temp $(dz)
$execute if score #tmp1 skys_horizon.temp matches 0.. if score #tmp2 skys_horizon.temp matches 0.. if score #tmp3 skys_horizon.temp matches 0.. positioned $(x) $(y) $(z) summon minecraft:marker run function skys_horizon:utility/zzz/foreach_block_in_area/step {\
    dx: $(dx), dy: $(dy), dz: $(dz), command: "$(command)"\
}
