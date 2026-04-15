# Main entry point for spaceship functionality.
# Check if the player is mounted on a spaceship, otherwise early return.
execute unless predicate skys_horizon:spaceship/is_mounted run return fail

execute unless dimension skys_horizon:space run function skys_horizon:spaceship/surface/update
execute if dimension skys_horizon:space run function skys_horizon:spaceship/space/update
function skys_horizon:spaceship/velocity/update_velocity
