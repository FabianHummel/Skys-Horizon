#ifdef VSH

flat out int planetId;
flat out int isPlanetAtmosphere;

const vec3 SUN_ATMOSPHERE_COLOR = vec3(252, 221, 126);

const vec3 SORAX4B_POSITION = vec3(0.0, 20.0, 0.0);
const vec3 SORAX4B_ATMOSPHERE_COLOR = vec3(255, 115, 0);

const vec3[] PLANET_POSITIONS = vec3[](
        SUN_POSITION,
        SORAX4B_POSITION
    );

const vec3[] PLANET_ATMOSPHERE_COLORS = vec3[](
        SUN_ATMOSPHERE_COLOR / 255.,
        SORAX4B_ATMOSPHERE_COLOR / 255.
    );

#endif

#ifdef FSH

flat in int planetId;
flat in int isPlanetAtmosphere;

float calculatePlanetAtmosphereBrightness(float angle) {
    return pow(angle, 3) * 20.0;
}

#endif
