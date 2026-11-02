#ifndef SKYS_HORIZON_LIB_QUATERNION_GLSL
#define SKYS_HORIZON_LIB_QUATERNION_GLSL

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

// rgb: 2-bit index + two 11-bit components, third component comes from the yaw
vec4 decodeRotationPrecise(vec3 color, float yaw) {
    ivec3 encoded = ivec3(round(color * 255.0));
    int index = encoded.r >> 6;

    int xI = ((encoded.r & 0x3F) << 5) + (encoded.g >> 3);
    float x = float(xI - 1024) / 1448.0;

    int yI = ((encoded.g & 0x7) << 8) + encoded.b;
    float y = float(yI - 1024) / 1448.0;

    // 1 / (PI * sqrt(2))
    const float scale = 0.225079079;
    float z = yaw * scale;

    return decodeQuaternion(x, y, z, index);
}

// rgb: 2-bit index + three 7-bit components
vec4 decodeRotationRough(vec3 color) {
    ivec3 encoded = ivec3(round(color * 255.0));
    int index = (encoded.r >> 5) & 0x3;

    int xI = ((encoded.r & 0x1F) << 2) + (encoded.g >> 6);
    float x = float(xI - 64) / 90.0;

    int yI = ((encoded.g & 0x3F) << 1) + (encoded.b >> 7);
    float y = float(yI - 64) / 90.0;

    int zI = encoded.b & 0x7F;
    float z = float(zI - 64) / 90.0;

    return decodeQuaternion(x, y, z, index);
}

vec3 rotate(vec3 v, vec4 q) {
    return v + 2.0 * cross(q.xyz, cross(q.xyz, v) + q.w * v);
}

vec4 conjugate(vec4 q) {
    return vec4(-q.xyz, q.w);
}

#endif
