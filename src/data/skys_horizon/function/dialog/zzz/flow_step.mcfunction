$data modify storage skys_horizon dialog.current_flow_element set from storage skys_horizon dialog.flow[$(pointer)]
data modify storage skys_horizon dialog.display_text set value ""
time of skys_horizon:dialog pause
execute if data storage skys_horizon {dialog:{current_flow_element:{type:"paragraph"}}} run return run function skys_horizon:dialog/zzz/paragraph_step
execute if data storage skys_horizon {dialog:{current_flow_element:{type:"paragraph"}}} run return run function skys_horizon:dialog/zzz/choice
