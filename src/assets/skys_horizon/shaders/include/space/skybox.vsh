if (alpha > 254 - NUM_SPACEWARP_ROTATION_OFFSETS && alpha <= 254) {
    const float PI = 3.1415926535897932;
    
    vec3 rotationOffset = getSpaceWarpRotationByIndex(alpha - 255 + NUM_SPACEWARP_ROTATION_OFFSETS);
    SpaceSkyboxRotation = (Color.rgb + rotationOffset) * PI / 2.0;

    vec2 cornerPos = corners[gl_VertexID % 4];
    vec2 screenPos = cornerPos;
    screenPos.x *= ScreenSize.x / ScreenSize.y;
    screenPos = vec2(
        screenPos.x * cos(SpaceSkyboxRotation.z) - screenPos.y * sin(SpaceSkyboxRotation.z),
        screenPos.x * sin(SpaceSkyboxRotation.z) + screenPos.y * cos(SpaceSkyboxRotation.z));
    Pos = vec3(screenPos, -1.0);
    gl_Position = vec4(cornerPos, 1.0, 1.0);
    return;
}