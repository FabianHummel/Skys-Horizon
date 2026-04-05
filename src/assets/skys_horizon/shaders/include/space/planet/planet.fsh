#if 0
void main()
#endif
{
    if (isPlanetAtmosphere == 1) {
        vec3 viewDir = normalize(Pos);
        float angle = dot(-vertexNormal, viewDir);
        float brightness = calculatePlanetAtmosphereBrightness(angle);
        float t = max(brightness - 1.0, 0.0);
        fragColor = vec4(mix(vertexColor.rgb, vec3(1.0), t), brightness);
        return;
    }

    if (planetId != -1) {
        color *= minecraft_mix_light(Light0_Direction, Light1_Direction, vertexNormal, overlayColor) * SUN_COLOR * ColorModulator;
        fragColor = color;
        return;
    }
}
