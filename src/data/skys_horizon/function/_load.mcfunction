scoreboard objectives add skys_horizon.temp dummy
scoreboard objectives add skys_horizon.counter dummy

scoreboard objectives add skys_horizon.const dummy
scoreboard players set #-1 skys_horizon.const -1
scoreboard players set #0 skys_horizon.const 0
scoreboard players set #1 skys_horizon.const 1
scoreboard players set #2 skys_horizon.const 2
scoreboard players set #10 skys_horizon.const 10
scoreboard players set #100 skys_horizon.const 100
scoreboard players set #360 skys_horizon.const 360
scoreboard players set #1.000 skys_horizon.const 1000
scoreboard players set #24.000 skys_horizon.const 24000
scoreboard players set #36.000 skys_horizon.const 36000
scoreboard players set #1.000.000 skys_horizon.const 1000000

scoreboard players set #2^4 skys_horizon.const 16
scoreboard players set #2^7 skys_horizon.const 128
scoreboard players set #2^8 skys_horizon.const 256
scoreboard players set #2^11 skys_horizon.const 2048
scoreboard players set #2^12 skys_horizon.const 4096
scoreboard players set #2^14 skys_horizon.const 16384
scoreboard players set #2^16 skys_horizon.const 65536
scoreboard players set #2^20 skys_horizon.const 1048576
scoreboard players set #2^21 skys_horizon.const 2097152
scoreboard players set #2^22 skys_horizon.const 4194304
scoreboard players set #2^24 skys_horizon.const 16777216

scoreboard players set #10^6 skys_horizon.const 1000000

data modify storage skys_horizon const.int_to_hex set value ['0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F']

forceload add 29999999 91665
setblock 29999999 0 91665 minecraft:barrel{Items:[{id:"minecraft:stone"}]}

execute unless data storage skys_horizon {initialized:1b} run schedule function skys_horizon:_reset 1t
