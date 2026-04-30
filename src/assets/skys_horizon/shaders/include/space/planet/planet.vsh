#if 0
void main()
#endif
{
    planetId = -1;
    isPlanetAtmosphere = 0;

    if (isObjmcModel == 1 && objmcMarker.a <= SPACE_PLANET_ALPHAS.x && objmcMarker.a > SPACE_PLANET_ALPHAS.y) {
        // Planet ID (0-9)
        planetId = SPACE_PLANET_ALPHAS.x - objmcMarker.a;
        isSpaceObject = true;

        vec3 playerPosition = CameraBlockPos - CameraOffset;
        vec3 planetPosition = PLANET_POSITIONS[planetId];
        planetAtmosphereColor = PLANET_ATMOSPHERE_COLORS[planetId];
        SunDirection = normalize(planetPosition - SUN_POSITION);
        vec3 planetDirection = planetPosition - PLAYER_ROT_MAT * playerPosition;
        float planetDistance = length(planetDirection);

        // Planet transformations
        vec3 translation = planetDirection;
        vec4 rotation = decodeRotationPrecise();
        float scale = 10.0;

        if (isPlanetAtmosphereMesh()) {
            isPlanetAtmosphere = 1;
            vertexNormal = rotate(-vertexNormal, rotation);
            scale += 1; // TODO: ~1 when player is near, but converges to ~5 at high distances.
        }

        Pos = rotate(posOffset * scale + translation, rotation);
    }
}
