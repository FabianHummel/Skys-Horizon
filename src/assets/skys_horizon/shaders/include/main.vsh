int alpha = getTextureAlpha();
Yaw = -atan(Normal.x, Normal.z);
Pitch = -atan(Normal.y, length(Normal.xz));

const float colorFix = 255.0 / 256.0;

if (alpha > 254 - NUM_SPACEWARP_ROTATION_OFFSETS && alpha <= 254) {
    vec3 rotationOffset = getSpaceWarpRotationByIndex(alpha - 255 + NUM_SPACEWARP_ROTATION_OFFSETS);
    SpaceSkyboxRotation = (Color.rgb + rotationOffset) * PI / 2.0;

    vec2 cornerPos = corners[gl_VertexID % 4];
    vec2 screenPos = cornerPos;
    screenPos.x *= ScreenSize.x / ScreenSize.y;
    screenPos = vec2(
        screenPos.x * cos(SpaceSkyboxRotation.z) - screenPos.y * sin(SpaceSkyboxRotation.z),
        screenPos.x * sin(SpaceSkyboxRotation.z) + screenPos.y * cos(SpaceSkyboxRotation.z));
    Pos = vec3(screenPos, -1.0);
    gl_Position = vec4(cornerPos, 1.0, 1.0);
    return;
}

if (isPlanetMarker(marker)) {
    ModelViewMat2 = mat4(1.0);
    ModelViewMat2[3] = ModelViewMat[3];

    ivec3 encodedRotation = ivec3(round(Color * 255.));
    int iPitch = encodedRotation.r << 4 | encodedRotation.g >> 4;
    float pitch = float(iPitch) * (2.0 * PI / 4095.0);
    int iRoll  = (encodedRotation.g & 0x0F) << 8 | encodedRotation.b;
    float roll  = -float(iRoll) * (2.0 * PI / 4095.0);
    posoffset = rotate(vec3(pitch, Yaw, roll)) * posoffset;
    Pos += posoffset;
}

else {
    Pos += posoffset;
}
