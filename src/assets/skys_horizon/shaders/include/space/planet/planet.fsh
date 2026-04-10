#if 0
void main()
#endif
{
    if (planetId != -1) {
        vec3 viewDir = normalize(Pos);
        float angle = dot(vertexNormal, viewDir);
        float lightValue = max(0.0, dot(SunDirection, vertexNormal));

        if (isPlanetAtmosphere == 1) {
            float brightness = calculatePlanetAtmosphereBrightness(angle) * lightValue;
            float t = max(brightness - 1.0, 0.0);
            fragColor = vec4(mix(planetAtmosphereColor, vec3(1.0), t), brightness);
            return;
        }

        vec4 sunLight = vec4(SUN_COLOR.rgb * lightValue * SUN_PLANET_INTENSITY + SPACE_AMBIENT_LIGHT, SUN_COLOR.a);
        float innerGlowBrightness = calculatePlanetInnerGlowBrightness(angle);
        // TODO: Implement inner glow
        fragColor = vec4(mix(color.rgb, planetAtmosphereColor, 0.0), color.a) * sunLight * ColorModulator;
        return;
    }
}
