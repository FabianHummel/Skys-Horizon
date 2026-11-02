#if 0
void main()
#endif
{
    isSpaceship = 0;

    if (markerColor.a == SPACESHIP_ALPHA && baseColor.rgb != vec3(0.0)) {
        isSpaceship = 1;
        isSpaceObject = true;

        vec3 playerPosition = CameraBlockPos - CameraOffset;
        vec4 rotation = decodeRotationRough();
        vertexNormal = rotate(-vertexNormal, rotation);
        SunDirection = normalize(PLAYER_ROT_MAT * playerPosition - SUN_POSITION);
        Pos = SPACESHIP_MAT * Pos;
    }
}
