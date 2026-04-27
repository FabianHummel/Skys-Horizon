function skys_horizon:space/warp/remove
#summon item_display 0 0 0 {\
    item_display: "head",\
    interpolation_duration: 5,\
    view_range: -1f,\
    transformation: {\
        left_rotation: [0f, 0f, 0f, 1f],\
        right_rotation: [0f, 0f, 0f, 1f],\
        translation: [0f, 0f, 0f],\
        scale: [10f, 10f, 10f]\
    },\
    item: {\
        id: "minecraft:leather_horse_armor",\
        count: 1,\
        components: {\
            "minecraft:item_model": "skys_horizon:space/warp",\
            "minecraft:dyed_color": 0\
        }\
    },\
    Tags: ["skys_horizon.space.warp"]\
}
