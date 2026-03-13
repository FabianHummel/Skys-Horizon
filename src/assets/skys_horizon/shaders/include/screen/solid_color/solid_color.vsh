#if 0
void main()
#endif
{
    isSolidColorMarker = 0;

    if (markerColor == ivec4(12, 34, 56, SOLID_COLOR_ALPHA)) {
        isSolidColorMarker = 1;

        vec2 cornerPos = SCREEN_CORNERS[gl_VertexID % 4];
        gl_Position = vec4(cornerPos, 1.0, 1.0);
        return;
    }
}
