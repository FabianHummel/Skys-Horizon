#if 0
void main()
#endif
{
    planetAtmosphereId = -1;

    if (markerColor.a <= SPACE_PLANET_ATMOSPHERE_ALPHAS.x && markerColor.a > SPACE_PLANET_ATMOSPHERE_ALPHAS.y) {
        // Disable rotation
        ModelViewMatTmp = mat4(1.0);
        ModelViewMatTmp[3] = ModelViewMat[3];

        // Absolute player position in world space
        vec3 playerPosition = CameraBlockPos - CameraOffset;

        // Planet-Atmosphere ID (0-9)
        planetAtmosphereId = SPACE_PLANET_ATMOSPHERE_ALPHAS.x - markerColor.a;

        // Absolute planet position in world space
        vec3 planetPosition = PLANET_POSITIONS[planetAtmosphereId];

        // Direction from player -> planet
        vec3 planetDirection = planetPosition - playerPosition;

        vec3 forward = normalize(-planetDirection);
        vec3 right = normalize(cross(vec3(0.0, 1.0, 0.0), forward));
        vec3 up = cross(forward, right);

        mat3 lookAt = mat3(
                right,
                up,
                forward
            );

        // Atmosphere transformations
        float scale = 15.0;
        vec3 rotation = decodeRotation();
        vec2 cornerPos = SCREEN_CORNERS[gl_VertexID % 4];
        texCoord = cornerPos / 2.0 + vec2(.5);
        posOffset = planetDirection + lookAt * vec3(cornerPos, 0.0) * scale;

        // Final vertex position
        Pos = rotate(rotation) * posOffset;
    }
}
