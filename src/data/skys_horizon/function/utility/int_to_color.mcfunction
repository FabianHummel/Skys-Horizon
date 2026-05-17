scoreboard players operation #in skys_horizon.temp %= #2^24 skys_horizon.const
scoreboard players operation #tmp1 skys_horizon.temp = #in skys_horizon.temp
scoreboard players operation #tmp1 skys_horizon.temp /= #2^20 skys_horizon.const
function skys_horizon:utility/int_to_color/append_hex_character { digit: 1 }

scoreboard players operation #in skys_horizon.temp %= #2^20 skys_horizon.const
scoreboard players operation #tmp1 skys_horizon.temp = #in skys_horizon.temp
scoreboard players operation #tmp1 skys_horizon.temp /= #2^16 skys_horizon.const
function skys_horizon:utility/int_to_color/append_hex_character { digit: 2 }

scoreboard players operation #in skys_horizon.temp %= #2^16 skys_horizon.const
scoreboard players operation #tmp1 skys_horizon.temp = #in skys_horizon.temp
scoreboard players operation #tmp1 skys_horizon.temp /= #2^12 skys_horizon.const
function skys_horizon:utility/int_to_color/append_hex_character { digit: 3 }

scoreboard players operation #in skys_horizon.temp %= #2^12 skys_horizon.const
scoreboard players operation #tmp1 skys_horizon.temp = #in skys_horizon.temp
scoreboard players operation #tmp1 skys_horizon.temp /= #2^8 skys_horizon.const
function skys_horizon:utility/int_to_color/append_hex_character { digit: 4 }

scoreboard players operation #in skys_horizon.temp %= #2^8 skys_horizon.const
scoreboard players operation #tmp1 skys_horizon.temp = #in skys_horizon.temp
scoreboard players operation #tmp1 skys_horizon.temp /= #2^4 skys_horizon.const
function skys_horizon:utility/int_to_color/append_hex_character { digit: 5 }

scoreboard players operation #in skys_horizon.temp %= #2^4 skys_horizon.const
scoreboard players operation #tmp1 skys_horizon.temp = #in skys_horizon.temp
function skys_horizon:utility/int_to_color/append_hex_character { digit: 6 }

function skys_horizon:utility/int_to_color/construct_hex_color with storage skys_horizon temp
