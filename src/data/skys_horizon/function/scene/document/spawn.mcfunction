$summon minecraft:interaction ~ ~ ~ {\
    width: 0f,\
    height: 0f,\
    Passengers:\
    [\
        {\
            id: "minecraft:slime",\
            Size: 1,\
            DeathLootTable: "minecraft:empty",\
            NoGravity: true,\
            Silent: true,\
            Invulnerable: true,\
            PersistenceRequired: true,\
            NoAI: true,\
            Tags: ["skys_horizon.interactable", "skys_horizon.scene.document"],\
            data: {\
                on_success: "function skys_horizon:scene/document/open"\
            },\
            Team: "skys_horizon.no_collision",\
            active_effects:\
            [\
                {\
                    id: "minecraft:invisibility",\
                    show_particles: false,\
                    amplifier: 1,\
                    duration: -1\
                }\
            ],\
            Passengers:\
            [\
                {\
                    id: "minecraft:item_display",\
                    item:\
                    {\
                        id: "minecraft:paper",\
                        components: {\
                            "minecraft:item_model": "$(model_id)",\
                            "minecraft:item_name": "$(name)"\
                        }\
                    },\
                    transformation:\
                    {\
                        translation: [0f, -0.4f, 0f],\
                        left_rotation: [0.707f, 0f, 0f, 0.707f],\
                        scale: [1f, 1f, 1f],\
                        right_rotation: [0f, 0f, 0f, 1f]\
                    }\
                }\
            ]\
        }\
    ]\
}
