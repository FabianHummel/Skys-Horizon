# Map three values (pitch, yaw and roll) to a vec3 (dye color):
# However, these values are each only mapped in 90° intervals, because the 4 states in which
#  cardinal direction the model is oriented at is passed through the model's texture marker.
#
#           ₂₄   ₂₀   ₁₆   ₁₂   ₈    ₄    ₀
# vec3 bits: 0000.0000.0000.0000.0000.0000
#           |---red---||-green--||--blue--|
#           |--pitch--||--yaw---||--roll--|

# Red (8 bits): (value % 2⁸) << 16
scoreboard players operation #out skys_horizon.temp = @s skys_horizon.space.pitch
scoreboard players operation #out skys_horizon.temp *= #65536 skys_horizon.const

# Green (8 bits): (value % 2⁸) << 8
scoreboard players operation #tmp1 skys_horizon.temp = @s skys_horizon.space.yaw
scoreboard players operation #tmp1 skys_horizon.temp *= #256 skys_horizon.const
scoreboard players operation #out skys_horizon.temp += #tmp1 skys_horizon.temp

# Blue (8 bits): (value % 2⁸) << 0
scoreboard players operation #out skys_horizon.temp += @s skys_horizon.space.roll
