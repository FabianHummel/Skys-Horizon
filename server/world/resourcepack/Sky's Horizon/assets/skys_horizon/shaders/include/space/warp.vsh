if (isWarpMarker()) {
    ModelViewMatTmp = mat4(1.0);
    ModelViewMatTmp[3] = ModelViewMat[3];

    // decode information into roll angle and effect opacity
    ivec3 encodedValues = ivec3(round(Color * 255.));
    int iRoll = encodedValues.r << 8 | encodedValues.g;
    float roll = float(iRoll) / 65536.;
    spaceWarpOpacity = float(encodedValues.b) / 255.;
}
