#ifndef SKYS_HORIZON_EFFECTS_SPACE_PLANET_GLSL
#define SKYS_HORIZON_EFFECTS_SPACE_PLANET_GLSL

// effect.y = planet id, effect.z = 1 for the atmosphere mesh
// payload0.rgb = atmosphere color, payload1.xyz = sun direction

#ifdef VSH

const vec3 SUN_ATMOSPHERE_COLOR = vec3(252, 221, 126);

const vec3 SORAX4B_POSITION = vec3(20.0, 20.0, 0.0);
const vec3 SORAX4B_ATMOSPHERE_COLOR = vec3(230, 115, 0);

const vec3[] PLANET_POSITIONS = vec3[](
        SUN_POSITION,
        SORAX4B_POSITION
    );

const vec3[] PLANET_ATMOSPHERE_COLORS = vec3[](
        SUN_ATMOSPHERE_COLOR / 255.0,
        SORAX4B_ATMOSPHERE_COLOR / 255.0
    );

void planet_vertex(inout ItemVertex v) {
    int planetId = SPACE_PLANET_ALPHAS.x - v.objmcMarker.a;
    vec3 planetPosition = PLANET_POSITIONS[planetId];
    vec3 planetDirection = planetPosition - PLAYER_ROT_MAT * spacePlayerPosition();

    vec4 rotation = decodeRotationPrecise(v.data, v.yaw);
    float scale = 10.0;

    // All UVs of the atmosphere mesh are (0, 0)
    bool isAtmosphere = length(v.uv) < 0.001;
    if (isAtmosphere) {
        v.normal = rotate(-v.normal, rotation);
        scale += 1.0; // TODO: ~1 when player is near, but converges to ~5 at high distances.
    }

    v.pos = rotate(v.objmcOffset * scale + planetDirection, rotation);
    v.modelView = withoutRotation(v.modelView);

    v.effect.y = planetId;
    v.effect.z = int(isAtmosphere);
    v.payload0 = vec4(PLANET_ATMOSPHERE_COLORS[planetId], 0.0);
    v.payload1 = vec4(normalize(planetPosition - SUN_POSITION), 0.0);
}

#endif

#ifdef FSH

float planetAtmosphereBrightness(float angle) {
    return pow(angle, 5.0) * 180.0;
}

float planetInnerGlowBrightness(float angle) {
    return pow(angle, 6.0) * 100.0;
}

bool planet_fragment(ItemFragment f, out vec4 color) {
    vec3 atmosphereColor = f.payload0.rgb;
    vec3 sunDirection = f.payload1.xyz;

    float angle = dot(f.normal, normalize(f.pos));
    float lightValue = max(0.0, dot(sunDirection, f.normal));

    if (f.effect.z == 1) {
        float brightness = planetAtmosphereBrightness(angle) * lightValue;
        float t = max(brightness - 1.0, 0.0);
        color = vec4(mix(atmosphereColor, vec3(1.0), t), brightness);
        return true;
    }

    // TODO: Implement inner glow (planetInnerGlowBrightness)
    color = f.color * sunLight(lightValue, SUN_PLANET_INTENSITY) * ColorModulator;
    return true;
}

#endif

#endif
