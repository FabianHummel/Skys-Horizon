execute unless dimension minecraft:overworld unless data storage skys_horizon {correct_reset_location:1b} run return run function {
    data merge storage skys_horizon {correct_reset_location:1b}
    execute in skys_horizon:space run function skys_horizon:_reset
}
data merge storage skys_horizon {correct_reset_location:0b}

tellraw @a {text:"Resetting world..."}
data merge storage skys_horizon {initialized:1b}
