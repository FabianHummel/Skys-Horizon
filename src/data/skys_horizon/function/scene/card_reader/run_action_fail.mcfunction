data modify entity @n[type=minecraft:item_display,tag=skys_horizon.scene.card_reader.lamp] item.id set value "minecraft:redstone_block"
function callback_scheduler:schedule {ticks: 10, selector: "@s", command: 'data modify entity @n[type=minecraft:item_display,tag=skys_horizon.scene.card_reader.lamp] item.id set value \\"minecraft:red_stained_glass\\"'}
playsound minecraft:block.note_block.pling master @a ~ ~ ~ 0.5 2
playsound minecraft:block.note_block.pling master @a ~ ~ ~ 0.5 1.9
execute on target run title @s actionbar {translate:"skys_horizon:scene/card_reader/invalid_key_card", color:"red"}
data modify storage skys_horizon temp.command set from entity @s data.on_fail
execute if data entity @s data.on_fail run function skys_horizon:utility/invoke with storage skys_horizon temp
data remove entity @s interaction
