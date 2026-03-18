#if 0
void main()
#endif
{
    isPlanetMarker = 0;

    if (isObjmcModel == 1 && objmcMarker.a == SPACE_PLANET_ALPHA) {
        isPlanetMarker = 1;

        ModelViewMatTmp = mat4(1.0);
        ModelViewMatTmp[3] = ModelViewMat[3];

        vec3 translation = vec3(0.0, 0.0, 0.0);

        float scale = 1.0;

        vec3 rotation = decodeRotation();

        Pos = rotate(rotation) * posoffset * scale + translation;
    }
}
