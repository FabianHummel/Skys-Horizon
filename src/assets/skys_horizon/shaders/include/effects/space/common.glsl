#ifndef SKYS_HORIZON_EFFECTS_SPACE_COMMON_GLSL
#define SKYS_HORIZON_EFFECTS_SPACE_COMMON_GLSL

const vec3 SUN_POSITION = vec3(0.0, 0.0, 0.0);
const vec4 SUN_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
const float SUN_PLANET_INTENSITY = 2.0;
const float SUN_OBJECT_INTENSITY = 0.3;
const float SPACE_AMBIENT_LIGHT = 0.1;

const mat3 PLAYER_ROT_MAT = mat3(
        -1.0, 0.0, 0.0,
        0.0, 1.0, 0.0,
        0.0, 0.0, -1.0);

#ifdef VSH

vec3 spacePlayerPosition() {
    return vec3(CameraBlockPos) - CameraOffset;
}

// Space objects ignore the camera rotation, they are placed relative to the player's view
mat4 withoutRotation(mat4 modelView) {
    mat4 result = mat4(1.0);
    result[3] = modelView[3];
    return result;
}

#endif

vec4 sunLight(float lightValue, float intensity) {
    return vec4(SUN_COLOR.rgb * lightValue * intensity + SPACE_AMBIENT_LIGHT, SUN_COLOR.a);
}

#endif
