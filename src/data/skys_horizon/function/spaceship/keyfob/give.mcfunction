give @s minecraft:structure_void[\
    minecraft:consumable={\
        consume_seconds: 2147483647,\
        has_consume_particles: false,\
        animation: block,\
        sound: {sound_id:""}\
    },\
    minecraft:custom_data={\
        "skys_horizon:items/keyfob": {},\
        "skys_horizon:interactable": {\
            increase: 1,\
            cancel: -1,\
            duration: 20,\
            command: "function skys_horizon:spaceship/keyfob/on_read"\
        }\
    },\
    minecraft:item_model="minecraft:paper",\
    minecraft:custom_name=[{\
        text: "Key Fob",\
        italic: false\
    }],\
    minecraft:lore=["Grants access to the spaceship"]\
]
