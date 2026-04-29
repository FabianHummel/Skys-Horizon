execute unless dimension skys_horizon:space unless data storage skys_horizon {correct_reset_location:1b} run return run function skys_horizon:utility/rerun_in {dimension: "skys_horizon:space", function: "skys_horizon:space/_reset"}
data merge storage skys_horizon {correct_reset_location:0b}

function skys_horizon:space/reset_rotation
