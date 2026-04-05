#if 0
void main()
#endif
{
    if (planetId != -1) {
        if (isPlanetAtmosphere == 1) {
            fragColor = vec4(vertexNormal, 1.0);
        }
        else {
            color *= minecraft_mix_light(Light0_Direction, Light1_Direction, vertexNormal, overlayColor) * SUN_COLOR * ColorModulator;
            fragColor = color;
        }
        return;
    }
}
