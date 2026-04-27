function skys_horizon:scene/hangar/skybox/remove
summon minecraft:item_display 80.0 5.5 -12.25 {\
    shadow_strength: 0f,\
    view_range: -1f,\
    item: {\
        id: "minecraft:stone",\
        count: 1,\
        components: {\
            "minecraft:item_model": "skys_horizon:scene/hangar/skybox"\
        }\
    },\
    transformation: {\
        left_rotation: [0f, 0f, 0f, 1f],\
        right_rotation: [0f, 0f, 0f, 1f],\
        scale: [19f, 10f, 19f],\
        translation: [0f, 0f, 0f]\
    },\
    Tags: ["skys_horizon.scene.hangar.skybox"]\
}
