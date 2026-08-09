setblock ~ ~ ~ minecraft:air
setblock ~ ~ ~-1 minecraft:stone

execute align xyz run summon falling_block ~.5 ~.05 ~.5 {\
    BlockState: {\
        Name: "minecraft:purpur_pillar",\
        Properties: { axis: "x" }\
    },\
    Tags: ["skys_horizon.scene.hangar.garage_door"],\
    NoGravity: 1b,\
    Time: -2147483648\
}

execute if predicate {condition:"minecraft:location_check",predicate:{position:{y:1.5}}} run tag @n[tag=skys_horizon.scene.hangar.garage_door] add skys_horizon.scene.hangar.garage_door.bottom_row
