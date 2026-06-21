function skys_horizon:spaceship/remove
$summon armor_stand ~ ~ ~ {\
    Silent: true,\
    Invulnerable: true,\
    Invisible: true,\
    Tags: ["skys_horizon.spaceship", "skys_horizon.spaceship.base"],\
    attributes: [\
        {\
            id: "minecraft:gravity",\
            base: 0.004d\
        },\
        {\
            id: "minecraft:scale",\
            base: 0.0d\
        }\
    ],\
    Passengers: [\
        {\
            id: "minecraft:item_display",\
            item_display: "head",\
            interpolation_duration: 10,\
            teleport_duration: 5,\
            transformation: {\
                left_rotation: [0f, 0f, 0f, 1f],\
                right_rotation: [0f, 0f, 0f, 10f],\
                translation: [0f, 1.876f, 0f],\
                scale: [1f, 1f, 1f]\
            },\
            item: {\
                id: "minecraft:leather_horse_armor",\
                count: 1,\
                components: {\
                    "minecraft:item_model": "skys_horizon:spaceship",\
                    "minecraft:dyed_color": 0,\
                    "minecraft:custom_model_data": {\
                        strings: [$(type)]\
                    }\
                }\
            },\
            Tags: ["skys_horizon.spaceship", "skys_horizon.spaceship.model"]\
        },\
        {\
            id: "minecraft:interaction",\
            width: 2f,\
            height: 2.5f,\
            Tags: ["skys_horizon.spaceship", "skys_horizon.spaceship.interaction", "skys_horizon.interactable"],\
            data: {\
                interaction_duration: 20,\
                on_success: "function skys_horizon:spaceship/enter"\
            }\
        }\
    ]\
}

rotate @n[tag=skys_horizon.spaceship.model] ~ ~
