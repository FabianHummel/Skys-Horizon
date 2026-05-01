# cosine approximation with Taylor series (fourth order):
# cos(θ) ≅ 1 - θ² ÷ 2! + θ⁴ ÷ 4!
data modify storage skys_horizon temp.x set from storage skys_horizon temp.theta
function gm:square with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
data modify storage skys_horizon temp.theta_squared set from storage gm:io out
data modify storage skys_horizon temp.y set value 2f
function gm:divide with storage skys_horizon temp
data modify storage skys_horizon temp.temp.x set from storage gm:io out
data modify storage skys_horizon temp.x set from storage skys_horizon temp.theta_squared
function gm:square with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
data modify storage skys_horizon temp.y set value 24f
function gm:divide with storage skys_horizon temp
data modify storage skys_horizon temp.temp.y set from storage gm:io out
function gm:add with storage skys_horizon temp.temp
data modify storage skys_horizon temp.y set from storage gm:io out
data modify storage skys_horizon temp.x set value 1f
function gm:subtract with storage skys_horizon temp
