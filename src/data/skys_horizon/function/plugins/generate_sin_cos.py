from math import cos, radians, sin

from beet import Context

output_scale = 10000
lookup_table = []

for i in range(0, 36000):
    sin_i = int(sin(radians(i / 100.0)) * output_scale)
    cos_i = int(cos(radians(i / 100.0)) * output_scale)
    lookup_table.append(f"[I;{sin_i},{cos_i}]")


def beet_default(ctx: Context):
    ctx.data.functions["skys_horizon:_load"].append(
        f"data modify storage skys_horizon const.angle_to_sin_cos set value [{','.join(lookup_table)}]"
    )
