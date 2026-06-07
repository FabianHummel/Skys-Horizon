data modify entity @n[type=minecraft:item_display,tag=skys_horizon.scene.card_reader.lamp] item.id set value "minecraft:emerald_block"
function callback_scheduler:schedule {ticks: 50, selector: "@s", command: 'data modify entity @n[type=minecraft:item_display,tag=skys_horizon.scene.card_reader.lamp] item.id set value \\"minecraft:light_blue_stained_glass\\"'}
playsound minecraft:block.note_block.pling master @a ~ ~ ~ 0.3 0.5
function callback_scheduler:schedule {ticks: 2, selector: "@s", command: "playsound minecraft:block.note_block.pling master @a ~ ~ ~ 0.3 1.0"}
function callback_scheduler:schedule {ticks: 4, selector: "@s", command: "playsound minecraft:block.note_block.pling master @a ~ ~ ~ 0.3 1.5"}
data modify storage skys_horizon temp.command set from entity @s data.on_success
execute if data entity @s data.on_success run function skys_horizon:utility/invoke with storage skys_horizon temp
data remove entity @s interaction
