#if 0
void main()
#endif
{
    if (isAnimatedLogoMarker == 1) {
        const vec3 LOGO_COLOR = vec3(0.05, 0.05, 0.05);

        vec4 color = texture(Sampler0, texCoord0);
        float timeScale = getTimeScale();

        // - Red channel has a configurable time scale (how long it takes to go from r=0 to r=255)
        // - Green channel is the tick-offset (g=40 -> 2s delay)
        // - Blue channel is currently unused
        //              |--------red--------| |-----green----|
        float progress = color.r / timeScale + color.g * 255.0 / 20.0;

        // Value from t=0 to t=24.000 to offset the GameTime.
        // Used to programmatically start the animation.
        // The lower 8 bits (red) and upper 8 bits (green) = 65.536 values
        //  which is more than the needed 24.000 ticks of the GameTime ;)
        //                 |--------red--------| |---green---|
        float timeOffset = (baseColor.r * 65536 + baseColor.g * 256.0) / 24000.0;

        float relativeSeconds = (GameTime - timeOffset) * 1200.0;

        fragColor = relativeSeconds > progress ? vec4(LOGO_COLOR, color.a * vertexColor.a) : vec4(0.0);
        return;
    }
}
