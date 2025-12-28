if (textureAlphaEquals(254)) {
    ModelViewMat2 = mat4(1.0);
    ModelViewMat2[3] = ModelViewMat[3];
}

if (isPlanetMarker(marker)) {
    ModelViewMat2 = mat4(1.0);
    ModelViewMat2[3] = ModelViewMat[3];

    vec3 rotation = Color.rgb * 2 * PI;
    Pos += rotate(rotation) * posoffset;
}
else {
    Pos += posoffset;
}
