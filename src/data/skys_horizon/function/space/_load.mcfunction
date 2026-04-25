# Space rotation quaternion
scoreboard objectives add skys_horizon.space.x dummy
scoreboard objectives add skys_horizon.space.y dummy
scoreboard objectives add skys_horizon.space.z dummy
scoreboard objectives add skys_horizon.space.w dummy

# Load precalculated sine and cosine values
function skys_horizon:space/_load_sin_cos

# Marker entity for various operations
forceload add 0 0
kill 0-0-0-0-0
summon item_display 0.0 0.0 0.0 {UUID:[I;0,0,0,0]}
