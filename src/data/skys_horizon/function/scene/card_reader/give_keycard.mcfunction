$give @s minecraft:structure_void[\
    minecraft:consumable={\
        consume_seconds: 2147483647,\
        has_consume_particles: false,\
        animation: block,\
        sound: {sound_id:""}\
    },\
    minecraft:custom_data={\
        "skys_horizon:items/card_reader": {\
            keys: $(keys)\
        },\
        "skys_horizon:interactable": {\
            increase: 1,\
            cancel: -1,\
            duration: 10,\
            command: "function skys_horizon:scene/card_reader/on_read"\
        }\
    },\
    minecraft:item_model="minecraft:paper",\
    minecraft:custom_name=[{\
        text: "$(name)",\
        italic: false\
    }],\
    minecraft:lore=[$(text)]\
]
