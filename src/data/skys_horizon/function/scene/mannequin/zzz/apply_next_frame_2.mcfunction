$data modify entity @s Pos set from entity @s data.animations.$(animation)[$(frame)].position
$data modify entity @s Rotation set from entity @s data.animations.$(animation)[$(frame)].rotation
$execute store result score #tmp1 skys_horizon.temp run data get entity @s data.animations.$(animation)
