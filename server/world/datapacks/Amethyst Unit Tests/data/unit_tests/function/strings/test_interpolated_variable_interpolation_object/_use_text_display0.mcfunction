# Created using Amethyst v1.0.1.0 on 2025-11-22.
data modify entity @s text set value {storage:'amethyst:',nbt:'19'}
execute in minecraft:overworld run data modify storage amethyst: 20 set from entity @s text
kill @s
