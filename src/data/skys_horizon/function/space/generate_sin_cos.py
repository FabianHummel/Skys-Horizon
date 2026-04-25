from math import cos, sin

from beet import Context, Function

num_data_points = 18_000
output_scale = 1_000
lookup_table = []

for i in range(0, num_data_points):
    sin_i = int(sin(i / num_data_points / 20.0) * output_scale)
    cos_i = int(cos(i / num_data_points / 20.0) * output_scale)
    lookup_table.append(f"[I;{sin_i},{cos_i}]")


def beet_default(ctx: Context):
    ctx.data.functions["skys_horizon:space/_load_sin_cos"] = Function(
        f"data modify storage skys_horizon const.space.angle_to_sin_cos set value [{','.join(lookup_table)}]"
    )
