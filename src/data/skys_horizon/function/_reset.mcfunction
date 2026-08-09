tellraw @a {text:"Resetting world..."}
function cb:internal/load_once
scoreboard players reset * skys_horizon.counter
data merge storage skys_horizon {initialized:1b}
