#if 0
void main()
#endif
{
    planetId = -1;
    isPlanetAtmosphere = 0;

    if (isObjmcModel == 1 && objmcMarker.a <= SPACE_PLANET_ALPHAS.x && objmcMarker.a > SPACE_PLANET_ALPHAS.y) {
        // Disable rotation
        ModelViewMatTmp = mat4(1.0);
        ModelViewMatTmp[3] = ModelViewMat[3];

        // Absolute player position in world space
        vec3 playerPosition = CameraBlockPos - CameraOffset;

        // Planet ID (0-9)
        planetId = SPACE_PLANET_ALPHAS.x - objmcMarker.a;

        vec3 planetPosition = PLANET_POSITIONS[planetId];
        planetAtmosphereColor = PLANET_ATMOSPHERE_COLORS[planetId];
        SunDirection = normalize(planetPosition - SUN_POSITION);
        vec3 planetDirection = planetPosition - playerPosition;
        float planetDistance = length(planetDirection);

        // Planet transformations
        vec3 translation = planetDirection;
        mat3 rotation = applyRotation(decodeRotation());
        float scale = 10.0;

        if (isPlanetAtmosphereMesh()) {
            isPlanetAtmosphere = 1;
            vertexNormal *= -1;
            scale += 1; // TODO: ~1 when player is near, but converges to ~5 at high distances.
        }

        vertexNormal = rotation * vertexNormal;
        Pos = rotation * (posOffset * scale + translation);
    }
}
