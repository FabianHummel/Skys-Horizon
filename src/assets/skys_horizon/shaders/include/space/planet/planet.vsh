#if 0
void main()
#endif
{
    planetMarker = 0;

    if (isObjmcModel == 1 && objmcMarker.a == SPACE_PLANET_ALPHA) {
        ModelViewMatTmp = mat4(1.0);
        ModelViewMatTmp[3] = ModelViewMat[3];

        planetMarker = getmeta(topleft, 8).r;

        vec3 playerPosition = CameraBlockPos - CameraOffset;
        vec3 planetPosition = PLANET_POSITIONS[planetMarker - 1];

        vec3 planetDirection = planetPosition - playerPosition;

        vec3 translation = planetDirection;

        float scale = 10.0;

        vec3 rotation = decodeRotation();

        Pos = rotate(rotation) * posoffset * scale + translation;
    }
}
