scoreboard players set $offset skys_horizon.crosshair 0
execute store result score #time skys_horizon.crosshair run time query gametime
data remove storage skys_horizon crosshair

scoreboard players reset * skys_horizon.crosshair.duration
