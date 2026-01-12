if (isPlanetMarker()) {
    const float PI = 3.1415926535897932;

    ModelViewMat2 = mat4(1.0);
    ModelViewMat2[3] = ModelViewMat[3];

    ivec3 encodedRotation = ivec3(round(Color * 255.));
    int iPitch = encodedRotation.r << 4 | encodedRotation.g >> 4;
    float pitch = float(iPitch) * (2.0 * PI / 4095.0);
    int iRoll  = (encodedRotation.g & 0x0F) << 8 | encodedRotation.b;
    float roll  = -float(iRoll) * (2.0 * PI / 4095.0);
    Pos += rotate(vec3(pitch, Yaw, roll)) * posoffset;
}