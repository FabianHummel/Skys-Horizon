#ifdef VSH

out float Yaw;
out float Pitch;
out vec3 SunDirection;

const vec3 SUN_POSITION = vec3(0.0, 0.0, 0.0);

const mat3 PLAYER_POS_MAT = mat3(
        -1.0, 0.0, 0.0,
        0.0, 1.0, 0.0,
        0.0, 0.0, -1.0);

#define TAU 6.28318530717958647692

vec3 decodeRotationPrecise() {
    ivec3 encodedRotation = ivec3(round(Color * 255.));
    int iPitch = encodedRotation.r << 4 | encodedRotation.g >> 4;
    float pitch = float(iPitch) * (TAU / 4095.0);
    int iRoll = (encodedRotation.g & 0x0F) << 8 | encodedRotation.b;
    float roll = -float(iRoll) * (TAU / 4095.0);
    return vec3(pitch, Yaw, roll);
}

vec3 decodeRotationRough() {
    ivec3 encodedRotation = ivec3(round(Color * 255.));
    float yaw = float(encodedRotation.r) * (TAU / 255.0);
    float pitch = float(encodedRotation.g) * (TAU / 255.0);
    float roll = float(encodedRotation.b) * (TAU / 255.0);
    return vec3(pitch, yaw, roll);
}

#endif

#ifdef FSH

in float Yaw;
in float Pitch;
in vec3 SunDirection;

const vec4 SUN_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
const float SUN_PLANET_INTENSITY = 2.0;
const float SUN_OBJECT_INTENSITY = 0.3;
const float SPACE_AMBIENT_LIGHT = 0.1;

#endif

#moj_import <skys_horizon:space/planet/planet.glsl>
#moj_import <skys_horizon:space/warp/warp.glsl>
#moj_import <skys_horizon:space/skybox/skybox.glsl>
#moj_import <skys_horizon:space/spaceship/spaceship.glsl>
