execute if block ~ ~ ~ minecraft:pale_oak_door[open=false] run playsound minecraft:block.wooden_door.open block @a ~ ~ ~
execute if block ~ ~ ~ minecraft:pale_oak_door[facing=north] run setblock ~ ~ ~ minecraft:pale_oak_door[open=true,facing=north]
execute if block ~ ~ ~ minecraft:pale_oak_door[facing=east] run setblock ~ ~ ~ minecraft:pale_oak_door[open=true,facing=east]
execute if block ~ ~ ~ minecraft:pale_oak_door[facing=south] run setblock ~ ~ ~ minecraft:pale_oak_door[open=true,facing=south]
execute if block ~ ~ ~ minecraft:pale_oak_door[facing=west] run setblock ~ ~ ~ minecraft:pale_oak_door[open=true,facing=west]
