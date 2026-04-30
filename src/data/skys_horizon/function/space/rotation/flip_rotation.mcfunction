data modify storage skys_horizon temp.y set value -1

data modify storage skys_horizon temp.x set from storage skys_horizon temp.rotation[0]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.rotation[0] set from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon temp.rotation[1]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.rotation[1] set from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon temp.rotation[2]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.rotation[2] set from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon temp.rotation[3]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.rotation[3] set from storage gm:io out
