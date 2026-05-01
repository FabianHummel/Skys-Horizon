# sine approximation with Taylor series (third order):
# sin(θ) ≅ θ - θ³ ÷ 3!
data modify storage skys_horizon temp.x set from storage skys_horizon temp.theta
function gm:square with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
data modify storage skys_horizon temp.y set from storage skys_horizon temp.theta
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
data modify storage skys_horizon temp.y set value 6f
function gm:divide with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage skys_horizon temp.theta
data modify storage skys_horizon temp.y set from storage gm:io out
function gm:subtract with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
