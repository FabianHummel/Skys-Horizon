#if 0
void main()
#endif
{
    crosshairId = -1;

    if (markerColor.rgb == ivec3(12, 34, 56) && markerColor.a <= CROSSHAIR_ALPHAS.x && markerColor.a >= CROSSHAIR_ALPHAS.y) {
        crosshairId = CROSSHAIR_ALPHAS.x - markerColor.a;

        texCoord0 = SCREEN_CORNERS[gl_VertexID % 4];
        Pos += vec3(-0.5, 0.0, 0.0);
    }
}
