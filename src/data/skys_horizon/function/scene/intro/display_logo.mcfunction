execute store result score #out skys_horizon.temp run time query gametime

scoreboard players operation #out skys_horizon.temp %= #24000 skys_horizon.const
scoreboard players operation #tmp1 skys_horizon.temp = #out skys_horizon.temp
scoreboard players operation #tmp1 skys_horizon.temp /= #4096 skys_horizon.const
function skys_horizon:scene/intro/append_hex_character {digit: "1"}

scoreboard players operation #out skys_horizon.temp %= #4096 skys_horizon.const
scoreboard players operation #tmp1 skys_horizon.temp = #out skys_horizon.temp
scoreboard players operation #tmp1 skys_horizon.temp /= #256 skys_horizon.const
function skys_horizon:scene/intro/append_hex_character {digit: "2"}

scoreboard players operation #out skys_horizon.temp %= #256 skys_horizon.const
scoreboard players operation #tmp1 skys_horizon.temp = #out skys_horizon.temp
scoreboard players operation #tmp1 skys_horizon.temp /= #16 skys_horizon.const
function skys_horizon:scene/intro/append_hex_character {digit: "3"}

scoreboard players operation #out skys_horizon.temp %= #16 skys_horizon.const
scoreboard players operation #tmp1 skys_horizon.temp = #out skys_horizon.temp
function skys_horizon:scene/intro/append_hex_character {digit: "4"}

function skys_horizon:scene/intro/construct_hex_color with storage skys_horizon temp
function skys_horizon:scene/intro/display_logo_internal with storage skys_horizon temp
