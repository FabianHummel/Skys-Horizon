$summon minecraft:interaction ~ ~ ~ {\
    Tags: ["skys_horizon.scene.card_reader", "skys_horizon.interactable"],\
    data:\
    {\
        on_success: "$(on_success)",\
        interaction_duration: 10\
    },\
    width: 0.5f,\
    height: 0.5f,\
    Passengers:\
    [\
        {\
            id: "minecraft:item_display",\
            Tags: ["skys_horizon.scene.card_reader.device"],\
            item:\
            {\
                id: "minecraft:polished_blackstone_button"\
            },\
            transformation:\
            {\
                left_rotation: [-0.61237246f, -0.35355338f, 0.35355338f, 0.61237246f],\
                translation: [0.09945612f, -0.24776037f, 0f],\
                right_rotation: [0f, 0f, 0f, 1f],\
                scale: [1.0f, 1.0f, 1.0f]\
            },\
            Passengers:\
            [\
                {\
                    id: "minecraft:item_display",\
                    Tags: ["skys_horizon.scene.card_reader.lamp"],\
                    item:\
                    {\
                        id: "minecraft:light_blue_stained_glass"\
                    },\
                    transformation:\
                    {\
                        left_rotation: [0f, 0f, -0.258819f, 0.9659259f],\
                        translation: [0f, -0.2f, 0f],\
                        right_rotation: [0f, 0f, 0f, 1f],\
                        scale: [0.12500001f, 0.12500001f, 0.125f]\
                    }\
                }\
            ]\
        }\
    ]\
}
