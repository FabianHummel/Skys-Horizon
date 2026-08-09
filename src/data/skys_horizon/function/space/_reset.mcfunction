# Rerun in space dimension
execute unless dimension skys_horizon:space in skys_horizon:space run return run function skys_horizon:space/_reset

data modify storage skys_horizon space.rotation set value [0.0f,0.0f,0.0f,1.0f]
