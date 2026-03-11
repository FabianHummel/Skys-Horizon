#if 0
void main()
#endif
{
    const vec3 BACKGROUND_COLOR = vec3(0.95, 0.95, 0.95);
    const vec3 LOGO_COLOR = vec3(0.05, 0.05, 0.05);

    if (isLogoAnimationMarker()) {
        vec4 color = texture(Sampler0, texCoord0);
        float progress = (color.r * 255.0 + color.g) / 256.0;
        vec3 finalColor = mod(GameTime * 1000.0, 1.0) > progress ? LOGO_COLOR : BACKGROUND_COLOR;
        fragColor = vec4(finalColor, color.a * vertexColor.a);
        return;
    }
}
