int alpha = getTextureAlpha();

if (alpha > 254 - NUM_SPACEWARP_ROTATION_OFFSETS && alpha <= 254) {
    ModelViewMat2 = mat4(1.0);
    ModelViewMat2[3] = ModelViewMat[3];
}

else if (isPlanetMarker(marker)) {
    ModelViewMat2 = mat4(1.0);
    ModelViewMat2[3] = ModelViewMat[3];

    ivec3 encodedRotation = ivec3(round(Color * 255.));
    int iPitch = encodedRotation.r << 4 | encodedRotation.g >> 4;
    float pitch = float(iPitch) * (2.0 * PI / 4095.0);
    float yaw = -atan(Normal.x, Normal.z);
    int iRoll  = (encodedRotation.g & 0x0F) << 8 | encodedRotation.b;
    float roll  = float(iRoll) * (2.0 * PI / 4095.0);
    posoffset = rotate(vec3(pitch, yaw, roll)) * posoffset;
    Pos += posoffset;
}

else {
    Pos += posoffset;
}
