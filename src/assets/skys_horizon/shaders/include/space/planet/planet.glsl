#ifdef VSH

flat out int planetId;
flat out int isPlanetAtmosphere;
out vec3 planetAtmosphereColor;

const vec3 SUN_ATMOSPHERE_COLOR = vec3(252, 221, 126);

const vec3 SORAX4B_POSITION = vec3(20.0, 20.0, 0.0);
const vec3 SORAX4B_ATMOSPHERE_COLOR = vec3(255, 115, 0);

const vec3[] PLANET_POSITIONS = vec3[](
        SUN_POSITION,
        SORAX4B_POSITION
    );

const vec3[] PLANET_ATMOSPHERE_COLORS = vec3[](
        SUN_ATMOSPHERE_COLOR / 255.,
        SORAX4B_ATMOSPHERE_COLOR / 255.
    );

// I set all the atmosphere mesh's UV coordinates to (0, 0), so this
// logic can be used to differentiate between it and the planet.
bool isPlanetAtmosphereMesh() {
    return length(texCoord) < 0.001;
}

#endif

#ifdef FSH

flat in int planetId;
flat in int isPlanetAtmosphere;
in vec3 planetAtmosphereColor;

float calculatePlanetAtmosphereBrightness(float angle) {
    return pow(angle, 3) * 30.0;
}

float calculatePlanetInnerGlowBrightness(float angle) {
    return pow(angle, 6) * 100.0;
}

#endif
