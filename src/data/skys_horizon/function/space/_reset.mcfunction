execute unless dimension skys_horizon:space unless data storage skys_horizon {correct_reset_location:1b} run return run function skys_horizon:utility/rerun_in {dimension: "skys_horizon:space", function: "skys_horizon:space/_reset"}
data merge storage skys_horizon {correct_reset_location:0b}

data modify storage skys_horizon space.rotation set value [0.0f, 0.0f, 0.0f, 1.0f]
