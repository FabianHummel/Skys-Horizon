execute unless dimension minecraft:overworld run tellraw @a {text:"Warning: A full reset must be run from the overworld!",color:"gold"}
execute unless dimension minecraft:overworld unless data storage skys_horizon {correct_reset_location:1b} run return run function skys_horizon:utility/rerun_in {dimension: "minecraft:overworld", function: "skys_horizon:_reset"}
data merge storage skys_horizon {correct_reset_location:0b}

tellraw @a {text:"Resetting world..."}
data merge storage skys_horizon {initialized:1b}

scoreboard players reset * skys_horizon.counter
