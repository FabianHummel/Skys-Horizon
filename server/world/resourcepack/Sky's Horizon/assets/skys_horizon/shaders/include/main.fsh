int alpha = getTextureAlpha();

if (alpha > 254 - NUM_SPACEWARP_ROTATION_OFFSETS && alpha <= 254) {
    vec3 viewDir = normalize(Pos);
    vec3 spaceColor = vec3(1.0);
    vec3 final = applySpaceWarp(viewDir, spaceColor, Yaw, Pitch);
    fragColor = vec4(final, 1.0);
    return;
}
