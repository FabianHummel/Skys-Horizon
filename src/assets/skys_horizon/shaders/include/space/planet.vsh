if (isPlanetMarker()) {
    ModelViewMat2 = mat4(1.0);
    ModelViewMat2[3] = ModelViewMat[3];

    vec3 rotation = decodeRotation();
    Pos += rotate(rotation) * posoffset;
}
