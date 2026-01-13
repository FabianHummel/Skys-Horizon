# Map yaw rotation directly (w/ two decimals accuracy)
execute store result entity @s Rotation[0] float 0.01 run scoreboard players get @p skys_horizon.space.yaw
# Refresh rotation
execute store result entity @s OnGround byte 1 if data entity @s {OnGround:0b}
