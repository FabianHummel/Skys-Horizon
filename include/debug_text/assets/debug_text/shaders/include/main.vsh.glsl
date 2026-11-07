layout(location = 6) flat out int isDebugMarker;
layout(location = 7) out vec2 corner;

void dt_vertex(out vec4 position)
{
    isDebugMarker = 0;
    if (ivec3(Color.rgb * 255.) == ivec3(1, 2, 3))
    {
        isDebugMarker = 1;
        corner = corners[gl_VertexIndex % 4] * vec2(1.0, .25) + vec2(0, .75);
        position = vec4(corner * 2. - 1., 0, 1);
    }
}
