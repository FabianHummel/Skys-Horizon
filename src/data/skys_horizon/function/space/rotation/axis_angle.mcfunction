# vec4(axis * sin(θ÷2), cos(θ÷2))
$execute store result storage skys_horizon temp.x float 0.0001 run scoreboard players get @s skys_horizon.spaceship.$(input)_velocity
data modify storage skys_horizon temp.y set value 2f
function gm:divide with storage skys_horizon temp
data modify storage skys_horizon temp.theta set from storage gm:io out

data modify storage skys_horizon temp.rotation set value [0f, 0f, 0f, 0f]

function skys_horizon:space/rotation/approximate_sin
$data modify storage skys_horizon temp.rotation[$(axis)] set from storage gm:io out

function skys_horizon:space/rotation/approximate_cos
data modify storage skys_horizon temp.rotation[3] set from storage gm:io out
