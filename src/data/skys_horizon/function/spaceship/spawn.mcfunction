function skys_horizon:spaceship/remove
summon armor_stand ~ ~ ~ {\
    Silent: true,\
    Invulnerable: true,\
    Small: true,\
    Invisible: true,\
    Tags: ["skys_horizon.spaceship", "skys_horizon.spaceship.base"],\
    attributes: [\
        {\
            id: "minecraft:gravity",\
            base: 0.004d\
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
                translation: [0f, 1f, 0f],\
                scale: [1f, 1f, 1f]\
            },\
            item: {\
                id: "minecraft:leather_horse_armor",\
                count: 1,\
                components: {\
                    "minecraft:item_model": "skys_horizon:spaceship",\
                    "minecraft:dyed_color": 16711680,\
                    "minecraft:custom_model_data": {\
                        strings: ["basic"]\
                    }\
                }\
            },\
            Tags: ["skys_horizon.spaceship", "skys_horizon.spaceship.model"]\
        }\
    ]\
}
ride @s mount @e[type=item_display,tag=skys_horizon.spaceship,limit=1,sort=nearest]
scoreboard players set @s skys_horizon.spaceship.velocity 0
