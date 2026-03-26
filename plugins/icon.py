from beet import Context, PngFile


def beet_default(ctx: Context):
    icon_path = ctx.meta.get("icon")
    if not icon_path:
        return

    for pack in ctx.packs:
        if pack.name is None:
            continue

        pack.icon = PngFile(source_path=icon_path)
