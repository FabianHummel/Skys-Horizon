data modify storage skys_horizon temp.summands set value []

#> x = a.w * b.x + a.x * b.w + a.y * b.z - a.z * b.y
data modify storage skys_horizon temp.x set from storage skys_horizon temp.rotation[3]
data modify storage skys_horizon temp.y set from storage skys_horizon space.rotation[0]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.summands append from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon temp.rotation[0]
data modify storage skys_horizon temp.y set from storage skys_horizon space.rotation[3]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.summands append from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon temp.rotation[1]
data modify storage skys_horizon temp.y set from storage skys_horizon space.rotation[2]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.summands append from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon temp.rotation[2]
data modify storage skys_horizon temp.y set from storage skys_horizon space.rotation[1]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
function gm:negate with storage skys_horizon temp
data modify storage skys_horizon temp.summands append from storage gm:io out

#> y = a.w * b.y - a.x * b.z + a.y * b.w + a.z * b.x
data modify storage skys_horizon temp.x set from storage skys_horizon temp.rotation[3]
data modify storage skys_horizon temp.y set from storage skys_horizon space.rotation[1]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.summands append from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon temp.rotation[0]
data modify storage skys_horizon temp.y set from storage skys_horizon space.rotation[2]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
function gm:negate with storage skys_horizon temp
data modify storage skys_horizon temp.summands append from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon temp.rotation[1]
data modify storage skys_horizon temp.y set from storage skys_horizon space.rotation[3]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.summands append from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon temp.rotation[2]
data modify storage skys_horizon temp.y set from storage skys_horizon space.rotation[0]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.summands append from storage gm:io out

#> z = a.w * b.z + a.x * b.y - a.y * b.x + a.z * b.w
data modify storage skys_horizon temp.x set from storage skys_horizon temp.rotation[3]
data modify storage skys_horizon temp.y set from storage skys_horizon space.rotation[2]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.summands append from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon temp.rotation[0]
data modify storage skys_horizon temp.y set from storage skys_horizon space.rotation[1]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.summands append from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon temp.rotation[1]
data modify storage skys_horizon temp.y set from storage skys_horizon space.rotation[0]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
function gm:negate with storage skys_horizon temp
data modify storage skys_horizon temp.summands append from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon temp.rotation[2]
data modify storage skys_horizon temp.y set from storage skys_horizon space.rotation[3]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.summands append from storage gm:io out

#> w = a.w * b.w - a.x * b.x - a.y * b.y - a.z * b.z
data modify storage skys_horizon temp.x set from storage skys_horizon temp.rotation[3]
data modify storage skys_horizon temp.y set from storage skys_horizon space.rotation[3]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.summands append from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon temp.rotation[0]
data modify storage skys_horizon temp.y set from storage skys_horizon space.rotation[0]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
function gm:negate with storage skys_horizon temp
data modify storage skys_horizon temp.summands append from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon temp.rotation[1]
data modify storage skys_horizon temp.y set from storage skys_horizon space.rotation[1]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
function gm:negate with storage skys_horizon temp
data modify storage skys_horizon temp.summands append from storage gm:io out

data modify storage skys_horizon temp.x set from storage skys_horizon temp.rotation[2]
data modify storage skys_horizon temp.y set from storage skys_horizon space.rotation[2]
function gm:multiply with storage skys_horizon temp
data modify storage skys_horizon temp.x set from storage gm:io out
function gm:negate with storage skys_horizon temp
data modify storage skys_horizon temp.summands append from storage gm:io out

execute in minecraft:overworld run item modify block 29999999 0 91665 container.0 {function:set_custom_model_data,floats:{mode:replace_all,values:[{type:sum,summands:[{type:storage,storage:"skys_horizon",path:"temp.summands[0]"},{type:storage,storage:"skys_horizon",path:"temp.summands[1]"},{type:storage,storage:"skys_horizon",path:"temp.summands[2]"},{type:storage,storage:"skys_horizon",path:"temp.summands[3]"}]}]}}
execute in minecraft:overworld run data modify storage skys_horizon space.rotation[0] set from block 29999999 0 91665 Items[0].components."minecraft:custom_model_data".floats[0]

execute in minecraft:overworld run item modify block 29999999 0 91665 container.0 {function:set_custom_model_data,floats:{mode:replace_all,values:[{type:sum,summands:[{type:storage,storage:"skys_horizon",path:"temp.summands[4]"},{type:storage,storage:"skys_horizon",path:"temp.summands[5]"},{type:storage,storage:"skys_horizon",path:"temp.summands[6]"},{type:storage,storage:"skys_horizon",path:"temp.summands[7]"}]}]}}
execute in minecraft:overworld run data modify storage skys_horizon space.rotation[1] set from block 29999999 0 91665 Items[0].components."minecraft:custom_model_data".floats[0]

execute in minecraft:overworld run item modify block 29999999 0 91665 container.0 {function:set_custom_model_data,floats:{mode:replace_all,values:[{type:sum,summands:[{type:storage,storage:"skys_horizon",path:"temp.summands[8]"},{type:storage,storage:"skys_horizon",path:"temp.summands[9]"},{type:storage,storage:"skys_horizon",path:"temp.summands[10]"},{type:storage,storage:"skys_horizon",path:"temp.summands[11]"}]}]}}
execute in minecraft:overworld run data modify storage skys_horizon space.rotation[2] set from block 29999999 0 91665 Items[0].components."minecraft:custom_model_data".floats[0]

execute in minecraft:overworld run item modify block 29999999 0 91665 container.0 {function:set_custom_model_data,floats:{mode:replace_all,values:[{type:sum,summands:[{type:storage,storage:"skys_horizon",path:"temp.summands[12]"},{type:storage,storage:"skys_horizon",path:"temp.summands[13]"},{type:storage,storage:"skys_horizon",path:"temp.summands[14]"},{type:storage,storage:"skys_horizon",path:"temp.summands[15]"}]}]}}
execute in minecraft:overworld run data modify storage skys_horizon space.rotation[3] set from block 29999999 0 91665 Items[0].components."minecraft:custom_model_data".floats[0]
