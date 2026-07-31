data remove storage skys_horizon temp.key
data modify storage skys_horizon temp.key set from entity @n[tag=skys_horizon.scene.card_reader, tag=find_looking.result] data.key
function skys_horizon:scene/card_reader/zzz/check_key with storage skys_horizon temp
execute if data entity @s {SelectedItem:{components:{"minecraft:custom_data":{"skys_horizon:items/card_reader":{keys:["category:operator"]}}}}} run scoreboard players set #tmp1 skys_horizon.temp 1
execute if predicate skys_horizon:scene/holding_keycard if score #tmp1 skys_horizon.temp matches 1 as @n[tag=skys_horizon.scene.card_reader, tag=find_looking.result] at @s run return run function skys_horizon:scene/card_reader/zzz/run_action_success
execute as @n[tag=skys_horizon.scene.card_reader, tag=find_looking.result] at @s run function skys_horizon:scene/card_reader/zzz/run_action_fail
