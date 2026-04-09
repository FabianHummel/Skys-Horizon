from beet import Context, ItemModel


def beet_default(ctx: Context):
    spaceship_types = ["basic"]

    ctx.assets["skys_horizon:spaceship"] = ItemModel(
        {
            "model": {
                "type": "minecraft:select",
                "property": "minecraft:custom_model_data",
                "cases": [
                    {
                        "when": type,
                        "model": {
                            "type": "minecraft:condition",
                            "property": "minecraft:custom_model_data",
                            "index": 0,
                            "on_false": {
                                "type": "minecraft:model",
                                "model": "skys_horizon:spaceship/" + type,
                                "tints": [{"type": "minecraft:dye", "default": 0}],
                            },
                            "on_true": {
                                "type": "minecraft:model",
                                "model": "skys_horizon:spaceship/" + type,
                                "tints": [{"type": "minecraft:dye", "default": 0}],
                                "transformation": [
                                    -1,
                                    0,
                                    0,
                                    1,
                                    0,
                                    1,
                                    0,
                                    0,
                                    -0,
                                    0,
                                    -1,
                                    1.6,
                                    0,
                                    0,
                                    0,
                                    1,
                                ],
                            },
                        },
                    }
                    for type in spaceship_types
                ],
            }
        }
    )
