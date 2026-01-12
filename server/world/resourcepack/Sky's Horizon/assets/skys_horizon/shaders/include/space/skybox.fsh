if (isSkyboxMarker()) {
    vec3 viewDir = normalize(Pos);
    vec3 spaceColor = vec3(1.0);
    vec3 final = applySpaceWarp(viewDir, spaceColor, Yaw, Pitch, SpaceSkyboxRotation);
    fragColor = vec4(final, 1.0);
    return;
}