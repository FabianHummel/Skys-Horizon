int alpha = getTextureAlpha();
Yaw = -atan(Normal.x, Normal.z);
Pitch = -atan(Normal.y, length(Normal.xz));

if (alpha > 254 - NUM_SPACEWARP_ROTATION_OFFSETS && alpha <= 254) {
    vec3 rotationOffset = -getSpaceWarpRotationByIndex(alpha - 254 - NUM_SPACEWARP_ROTATION_OFFSETS);

    float pitch = (Color.r + rotationOffset.x) * PI / 2.0;
    float yaw = (Color.g + rotationOffset.y) * PI / 2.0;
    float roll = (Color.b + rotationOffset.z) * PI / 2.0;
    vec3 rotation = vec3(pitch, yaw, roll);
    ModelViewMat2 = ModelViewMat2 * mat4(rotate(rotation));

    vec2 screenPos = corners[gl_VertexID % 4];
    Pos = vec3(screenPos * vec2(ScreenSize.x / ScreenSize.y, 1.0), -1.0);
    gl_Position = vec4(screenPos, 1.0, 1.0);
    return;
}

if (isPlanetMarker(marker)) {
    ModelViewMat2 = mat4(1.0);
    ModelViewMat2[3] = ModelViewMat[3];

    ivec3 encodedRotation = ivec3(round(Color * 255.));
    int iPitch = encodedRotation.r << 4 | encodedRotation.g >> 4;
    float pitch = float(iPitch) * (2.0 * PI / 4095.0);
    int iRoll  = (encodedRotation.g & 0x0F) << 8 | encodedRotation.b;
    float roll  = float(iRoll) * (2.0 * PI / 4095.0);
    posoffset = rotate(vec3(pitch, Yaw, roll)) * posoffset;
    Pos += posoffset;
}

else {
    Pos += posoffset;
}
