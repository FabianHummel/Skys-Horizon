# Main entry point for spaceship functionality.
# Check if the player is mounted on a spaceship, otherwise early return.
execute unless predicate skys_horizon:spaceship/is_mounted run return fail

function skys_horizon:spaceship/update_steering
function skys_horizon:spaceship/update_velocity