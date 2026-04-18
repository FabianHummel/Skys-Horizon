#if 0
void main()
#endif
{
    isSpaceship = 0;

    // Pretty scuffed and not very good, I know...
    if (isObjmcModel == 0 && baseColor.rgb != vec3(0.0)) {
        isSpaceship = 1;
        isSpaceObject = true;

        vec3 playerPosition = CameraBlockPos - CameraOffset;
        mat3 rotation = applyRotation(decodeRotationRough());
        vertexNormal = rotation * -vertexNormal;
        SunDirection = normalize(PLAYER_ROT_MAT * playerPosition - SUN_POSITION);
        Pos = SPACESHIP_MAT * Pos;
    }
}
