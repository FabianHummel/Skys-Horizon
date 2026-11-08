layout(location = 7) flat out int isDebugMarker;
layout(location = 8) out vec2 corner;

bool dt_vertex(inout vec4 position)
{
    const vec2[] corners = vec2[](
            vec2(0.0, 1.0),
            vec2(0.0, 0.0),
            vec2(1.0, 0.0),
            vec2(1.0, 1.0)
        );

    isDebugMarker = 0;
    if (ivec3(Color.rgb * 255.) != ivec3(1, 2, 3))
    {
        return false;
    }

    isDebugMarker = 1;
    corner = corners[gl_VertexIndex % 4] * vec2(1.0, .25) + vec2(0, .75);
    position = vec4(corner * 2. - 1., 1, 1);
    return true;
}
