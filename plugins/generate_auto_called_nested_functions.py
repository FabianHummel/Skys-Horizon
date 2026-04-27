from beet import Context, Function

function_types = ["_reset", "_tick", "_load"]


def beet_default(ctx: Context):
    for [path, directories, _] in ctx.data.functions.walk():
        if not path.startswith("skys_horizon"):
            continue

        for function_type in function_types:
            current_function = ctx.data.functions.setdefault(
                f"{path}{function_type}", Function()
            )
            for directory in directories:
                current_function.lines.append(
                    f"function {path}{directory}/{function_type}"
                )
