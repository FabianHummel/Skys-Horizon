#if 0
void main()
#endif
{
    isSpaceship = 0;

    if (isObjmcModel == 0 && (int(Color.r * 255.) >> 7) == 0) {
        isSpaceship = 1;
        isSpaceObject = true;

        vec3 playerPosition = CameraBlockPos - CameraOffset;
        mat3 rotation = applyRotation(decodeRotation());
        vertexNormal = rotation * -vertexNormal;
        SunDirection = normalize(playerPosition - SUN_POSITION);
    }
}
