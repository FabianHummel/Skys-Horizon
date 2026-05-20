from beet import Context, Function


def beet_default(ctx: Context):
    functions_to_add: dict[str, Function] = {}

    for [path, function] in ctx.data.functions.items():
        result = []
        i = 0
        num = 0
        while i < len(function.text):
            if function.text.startswith("function {", i):
                i += len("function {")
                start_i = i
                num += 1
                depth = 1
                new_path = f"{path}/_inline_{num}"
                while i < len(function.text) and depth > 0:
                    if function.text[i] == "{":
                        depth += 1
                    elif function.text[i] == "}":
                        depth -= 1
                    if depth == 0:
                        functions_to_add[new_path] = Function(function.text[start_i:i])
                    i += 1
                result.append(f"function {new_path}")
            else:
                result.append(function.text[i])
                i += 1
        function.text = "".join(result)

    for [path, function] in functions_to_add.items():
        ctx.data.functions[path] = function
