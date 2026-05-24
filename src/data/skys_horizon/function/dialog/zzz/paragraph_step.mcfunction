execute if data storage skys_horizon dialog.current_flow_element.sound run function skys_horizon:dialog/zzz/play_sound with storage skys_horizon dialog.current_flow_element

data modify storage skys_horizon dialog.current_rate set value 1.0f
function skys_horizon:dialog/zzz/set_rate_from_participant with storage skys_horizon dialog.current_flow_element
execute if data storage skys_horizon dialog.current_flow_element.rate run data modify storage skys_horizon dialog.current_rate set from storage skys_horizon dialog.current_flow_element.rate
function skys_horizon:dialog/zzz/set_clock_rate with storage skys_horizon dialog
time of skys_horizon:dialog resume

say TODO: Implement typewriter effect
