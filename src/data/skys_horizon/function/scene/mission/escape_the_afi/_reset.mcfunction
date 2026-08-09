function skys_horizon:scene/mission/escape_the_afi/starting_sequence/remove/all
gamemode adventure @a
execute at 3ee6de8e-da44-418f-8b4e-ec86d6fdb3ab run setblock ~ ~ ~ minecraft:air
tag 5961a478-9659-419a-8827-dd175ede5bf9 add skys_horizon.scene.location_check.active
execute in minecraft:overworld run tp @s 149.5 12.00 -5.5 0.0 0.0
