advancement revoke @s only skys_horizon:scene/card_reader
execute if predicate skys_horizon:scene/holding_keycard as @n[type=minecraft:interaction,nbt={interaction:{}}] at @s run return run function skys_horizon:scene/card_reader/run_action_success
execute as @n[type=minecraft:interaction,nbt={interaction:{}}] at @s run function skys_horizon:scene/card_reader/run_action_fail
