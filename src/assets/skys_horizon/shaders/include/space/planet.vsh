if (isPlanetMarker()) {
    ModelViewMatTmp = mat4(1.0);
    ModelViewMatTmp[3] = ModelViewMat[3];

    vec3 rotation = decodeRotation();
    Pos += rotate(rotation) * posoffset;
}
