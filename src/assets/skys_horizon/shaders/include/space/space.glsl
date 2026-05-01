#ifdef VSH

out float Yaw;
out float Pitch;
out vec3 SunDirection;

const vec3 SUN_POSITION = vec3(0.0, 0.0, 0.0);

const mat3 PLAYER_ROT_MAT = mat3(
        -1.0, 0.0, 0.0,
        0.0, 1.0, 0.0,
        0.0, 0.0, -1.0);

vec4 decodeQuaternion(float x, float y, float z, int index) {
    float w = sqrt(1.0 - x * x - y * y - z * z);

    switch (index) {
        case 0:
        return normalize(vec4(w, x, y, z));
        case 1:
        return normalize(vec4(x, w, y, z));
        case 2:
        return normalize(vec4(x, y, w, z));
        case 3:
        return normalize(vec4(x, y, z, w));
        default:
        return vec4(0, 0, 0, 1);
    }
}

vec4 decodeRotationPrecise() {
    ivec3 encoded = ivec3(round(Color * 255.));
    int index = encoded.r >> 6;

    int xI = ((encoded.r & 0x3F) << 5) + (encoded.g >> 3);
    float x = float(xI - 1024) / 1448.0f;

    int yI = ((encoded.g & 0x7) << 8) + encoded.b;
    float y = float(yI - 1024) / 1448.0f;

    // 1 ÷ (π × √(2))
    const float scale = 0.225079079;
    float z = Yaw * scale;

    return decodeQuaternion(x, y, z, index);
}

vec4 decodeRotationRough() {
    ivec3 encoded = ivec3(round(Color * 255.));
    int index = (encoded.r >> 5) & 0x3;

    int xI = ((encoded.r & 0x1F) << 2) + (encoded.g >> 6);
    float x = float(xI - 64) / 90.0f;

    int yI = ((encoded.g & 0x3F) << 1) + (encoded.b >> 7);
    float y = float(yI - 64) / 90.0f;

    int zI = encoded.b & 0x7F;
    float z = float(zI - 64) / 90.0f;

    return decodeQuaternion(x, y, z, index);
}

vec3 rotate(vec3 v, vec4 q) {
    return v + 2.0 * cross(q.xyz, cross(q.xyz, v) + q.w * v);
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
