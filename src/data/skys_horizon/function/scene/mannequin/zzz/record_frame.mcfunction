title @s actionbar {text: "Recording...", color: "green"}
data modify storage skys_horizon scene.mannequin.frames append value {}
data modify storage skys_horizon scene.mannequin.frames[-1].position set from entity @s Pos
data modify storage skys_horizon scene.mannequin.frames[-1].rotation set from entity @s Rotation
