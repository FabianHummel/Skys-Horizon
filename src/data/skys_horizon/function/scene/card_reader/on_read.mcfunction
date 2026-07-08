execute if predicate skys_horizon:scene/holding_keycard as @n[tag=skys_horizon.scene.card_reader, tag=find_looking.result] at @s run return run function skys_horizon:scene/card_reader/run_action_success
execute as @n[tag=skys_horizon.scene.card_reader, tag=find_looking.result] at @s run function skys_horizon:scene/card_reader/run_action_fail
