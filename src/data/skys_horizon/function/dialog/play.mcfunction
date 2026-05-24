$data modify storage skys_horizon dialog set value {\
    participants: $(participants),\
    flow: $(flow),\
    pointer: 0\
}
time of skys_horizon:dialog set 0
function skys_horizon:dialog/zzz/flow_step with storage skys_horizon dialog
