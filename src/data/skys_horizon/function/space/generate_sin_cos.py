from math import cos, sin

from beet import Context, Function

output_scale = 1_000_000
input_scale = 1_800
lookup_table = []

for i in range(0, input_scale):
    sin_i = int(sin(i / input_scale) * output_scale)
    cos_i = int(cos(i / input_scale) * output_scale)
    lookup_table.append(f"[I;{sin_i},{cos_i}]")


def beet_default(ctx: Context):
    ctx.data.functions["skys_horizon:space/_load_sin_cos"] = Function(
        f"data modify storage skys_horizon const.space.angle_to_sin_cos set value [{','.join(lookup_table)}]"
    )
