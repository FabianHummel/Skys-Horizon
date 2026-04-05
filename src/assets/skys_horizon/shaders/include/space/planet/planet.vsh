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

        // Absolute planet position in world space
        vec3 planetPosition = PLANET_POSITIONS[planetId];

        // Direction from player -> planet
        vec3 planetDirection = planetPosition - playerPosition;

        // Distance from player -> planet
        float distance = length(planetDirection);

        // Planet transformations
        vec3 translation = planetDirection;
        vec3 rotation = decodeRotation();
        float scale = 10.0;

        // Differentiate mesh between planet and atmosphere
        if (length(texCoord) < 0.001) {
            isPlanetAtmosphere = 1;
            scale += 5.0; // TODO: ~1 when player is near, but converges to ~5 at high distances.
        }

        // Final vertex position
        Pos = rotate(rotation) * (posOffset * scale + translation);
    }
}
