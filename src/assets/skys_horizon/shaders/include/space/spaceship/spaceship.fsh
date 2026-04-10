#if 0
void main()
#endif
{
    if (isSpaceship == 1) {
        float lightValue = min(1.0, max(0.0, dot(SunDirection, vertexNormal)));
        vec4 sunLight = vec4(SUN_COLOR.rgb * lightValue * SUN_OBJECT_INTENSITY + SPACE_AMBIENT_LIGHT, SUN_COLOR.a);
        fragColor = color * sunLight * ColorModulator;
        isSpaceObject = true;
    }
}
