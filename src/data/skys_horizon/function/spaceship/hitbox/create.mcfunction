$summon minecraft:armor_stand ~ ~ ~ {\
    Silent: true,\
    Invulnerable: true,\
    NoGravity: true,\
    Tags: ["skys_horizon.spaceship", "skys_horizon.spaceship.hitbox", "skys_horizon.spaceship.hitbox.$(role)"],\
    Invisible: true,\
    attributes: [\
        {\
            id: "minecraft:scale",\
            base: 0.0d\
        }\
    ],\
    Passengers: [\
        {\
            id: "minecraft:shulker",\
            NoAI: true,\
            Silent: true,\
            Invulnerable: true,\
            Tags: ["skys_horizon.spaceship"],\
            DeathLootTable: "minecraft:empty",\
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
                    base: $(scale)\
                }\
            ]\
        }\
    ]\
}
