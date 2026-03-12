#if 0
void main()
#endif
{
    const vec3 BACKGROUND_COLOR = vec3(0.95, 0.95, 0.95);
    const vec3 LOGO_COLOR = vec3(0.05, 0.05, 0.05);

    if (isLogoAnimationMarker()) {
        vec4 color = texture(Sampler0, texCoord0);
        float timeScale = getTimeScale();

        // - Red channel has a configurable time scale (how long it takes to go from r=0 to r=255)
        // - Blue channel is the tick-offset (b=40 -> 2s delay)
        // - Green channel is currently unused
        //              |--------red--------| |-----green----|
        float progress = color.r / timeScale - color.g / 20.0;

        // Value from t=0 to t=24.000 to offset the GameTime.
        // Used to programmatically start the animation.
        // The lower 8 bits (red) and upper 8 bits (green) = 65.536 values
        //  which is more than the needed 24.000 ticks of the GameTime ;)
        //                 |--------red--------| |---green---|
        float timeOffset = (baseColor.r * 255.0 + baseColor.g) / 256.0;

        vec3 finalColor = (GameTime - timeOffset) * 1200.0 > progress ? LOGO_COLOR : BACKGROUND_COLOR;
        fragColor = vec4(finalColor, color.a * vertexColor.a);
        return;
    }
}
