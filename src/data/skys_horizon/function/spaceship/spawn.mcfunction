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
            id: "minecraft:armor_stand",\
            Silent: true,\
            Invulnerable: true,\
            Invisible: true,\
            Tags: ["skys_horizon.spaceship", "skys_horizon.spaceship.mount"],\
            attributes: [\
                {\
                    id: "minecraft:scale",\
                    base: 0.6d\
                }\
            ]\
        },\
        {\
            id: "minecraft:item_display",\
            item_display: "head",\
            interpolation_duration: 10,\
            teleport_duration: 5,\
            transformation: {\
                left_rotation: [0f, 0f, 0f, 1f],\
                right_rotation: [0f, 0f, 0f, 10f],\
                translation: [0f, 2.6f, 0.8f],\
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
            id: "minecraft:shulker",\
            NoAI: true,\
            Silent: true,\
            Invulnerable: true,\
            Tags: ["skys_horizon.spaceship", "skys_horizon.spaceship.hitbox", "skys_horizon.spaceship.hitbox.center", "skys_horizon.spaceship.interaction", "skys_horizon.interactable"],\
            DeathLootTable: "minecraft:empty",\
            data: {\
                interaction_duration: 20,\
                on_success: "function skys_horizon:spaceship/enter"\
            },\
            active_effects: [\
                {\
                    "id": "minecraft:invisibility",\
                    "duration": -1,\
                    "amplifier": 1,\
                    "show_particles": false\
                }\
            ],\
            attributes: [\
                {\
                    id: "minecraft:scale",\
                    base: 2.5d\
                }\
            ]\
        }\
    ]\
}

rotate @n[tag=skys_horizon.spaceship.model] ~ ~
