# Encode space rotation in dye color and model rotation
execute if dimension skys_horizon:space run function skys_horizon:space/shared/apply_rotation_rough
execute unless dimension skys_horizon:space run function skys_horizon:space/shared/reset_rotation
