function skys_horizon:space/skybox/remove
summon item_display 0 0 0 {\
    item_display: "head",\
    teleport_duration: 5,\
    view_range: -1f,\
    item: {\
        id: "minecraft:leather_horse_armor",\
        count: 1,\
        components: {\
            "minecraft:item_model": "skys_horizon:space/skybox",\
            "minecraft:dyed_color": 0\
        }\
    },\
    Tags: ["skys_horizon.space.skybox"]\
}
