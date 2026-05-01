#> √(x² + y² + z² + w²)
data modify storage skys_horizon temp.x set from storage skys_horizon space.rotation[0]
data modify storage skys_horizon temp.y set from storage skys_horizon space.rotation[1]
data modify storage skys_horizon temp.z set from storage skys_horizon space.rotation[2]
function gm:zzz/distance_handling with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
data modify storage skys_horizon temp.y set from storage skys_horizon space.rotation[3]
data modify storage skys_horizon temp.z set value 0f
function gm:zzz/distance_handling with storage skys_horizon temp
data modify storage skys_horizon temp.y set from storage gm:io out

# Divide components through length
data modify storage skys_horizon temp.x set from storage skys_horizon space.rotation[0]
function gm:divide with storage skys_horizon temp
data modify storage skys_horizon space.rotation[0] set from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon space.rotation[1]
function gm:divide with storage skys_horizon temp
data modify storage skys_horizon space.rotation[1] set from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon space.rotation[2]
function gm:divide with storage skys_horizon temp
data modify storage skys_horizon space.rotation[2] set from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon space.rotation[3]
function gm:divide with storage skys_horizon temp
data modify storage skys_horizon space.rotation[3] set from storage gm:io out
