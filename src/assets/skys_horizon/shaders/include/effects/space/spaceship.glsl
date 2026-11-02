#ifndef SKYS_HORIZON_EFFECTS_SPACE_SPACESHIP_GLSL
#define SKYS_HORIZON_EFFECTS_SPACE_SPACESHIP_GLSL

// payload1.xyz = sun direction

#ifdef VSH

const mat3 SPACESHIP_MAT = mat3(
        -1.0, 0.0, 0.0,
        0.0, 1.0, 0.0,
        0.0, 0.0, -2.0);

void spaceship_vertex(inout ItemVertex v) {
    vec4 rotation = decodeRotationRough(v.data);
    v.normal = rotate(-v.normal, rotation);
    v.pos = SPACESHIP_MAT * v.pos;
    v.modelView = withoutRotation(v.modelView);
    v.payload1 = vec4(normalize(PLAYER_ROT_MAT * spacePlayerPosition() - SUN_POSITION), 0.0);
}

#endif

#ifdef FSH

bool spaceship_fragment(ItemFragment f, out vec4 color) {
    #ifdef ALPHA_CUTOUT
    if (f.color.a < ALPHA_CUTOUT) {
        discard;
    }
    #endif

    float lightValue = clamp(dot(f.payload1.xyz, f.normal), 0.0, 1.0);
    color = f.color * sunLight(lightValue, SUN_OBJECT_INTENSITY) * ColorModulator;
    return true;
}

#endif

#endif
