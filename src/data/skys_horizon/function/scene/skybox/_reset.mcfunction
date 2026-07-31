function skys_horizon:scene/skybox/remove
summon minecraft:item_display 158 47 30 {\
    shadow_strength: 0f,\
    view_range: -1f,\
    item: {\
        id: "minecraft:stone",\
        count: 1,\
        components: {\
            "minecraft:item_model": "skys_horizon:scene/skybox"\
        }\
    },\
    transformation: {\
        left_rotation: [0f, 0f, 0f, 1f],\
        right_rotation: [0f, 0f, 0f, 1f],\
        scale: [500.0f, 500.0f, 500.0f],\
        translation: [0f, 0f, 0f]\
    },\
    Tags: ["skys_horizon.scene.skybox"]\
}
