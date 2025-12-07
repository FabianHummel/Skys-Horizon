# Created using Amethyst v1.0.1.0 on 2025-11-22.
data modify entity @s text set value {score:{objective:'amethyst',name:'10'}}
execute in minecraft:overworld run data modify storage amethyst: 11 set from entity @s text
kill @s
