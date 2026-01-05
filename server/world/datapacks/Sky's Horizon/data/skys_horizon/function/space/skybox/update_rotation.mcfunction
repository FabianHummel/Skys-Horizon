# Map intensity directly (w/ two decimals accuracy)
execute store result entity @s Rotation[0] float 0.01 run scoreboard players get @p skys_horizon.space.warp_timeoffset
execute store result entity @s Rotation[1] float 0.1 run scoreboard players get @p skys_horizon.space.warp_intensity
execute store result entity @s OnGround byte 1 if data entity @s {OnGround:0b}
