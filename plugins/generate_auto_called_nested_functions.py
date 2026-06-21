from beet import Context, Function

function_types = ["_reset", "_tick", "_load"]


def beet_default(ctx: Context):
    for [path, directories, _] in reversed(list(ctx.data.functions.walk())):
        for function_type in function_types:
            for directory in directories:
                function_path = f"{path}{directory}/{function_type}"
                if ctx.data.functions.get(function_path) is None:
                    continue

                function = ctx.data.functions.setdefault(
                    f"{path}{function_type}", Function()
                )

                try:
                    index = function.lines.index("#__skys_horizon:insertion_point__")
                    function.lines.insert(index, f"function {function_path}")
                except ValueError:
                    function.lines.append(f"function {function_path}")
