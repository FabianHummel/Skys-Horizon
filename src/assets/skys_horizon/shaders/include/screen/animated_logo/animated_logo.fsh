#if 0
void main()
#endif
{
    if (isAnimatedLogoMarker == 1) {
        const float ANIMATED_LOGO_TIME_SCALE = 0.4;
        const vec3 LOGO_COLOR = vec3(0.05, 0.05, 0.05);

        vec4 color = texture(Sampler0, texCoord0);
        if (color.a < 0.1) {
            discard;
        }

        // - Red channel has a configurable time scale (how long it takes to go from r=0 to r=255)
        // - Green channel is the tick-offset (g=255 -> 10s delay)
        // - Blue channel is currently unused
        ivec4 iBaseColor = ivec4(baseColor * 255);

        // Value from t=0 to t=24.000 to offset the GameTime.
        // Used to programmatically start the animation.
        // The lower 8 bits (red) and upper 8 bits (green) = 65.536 values
        //  which is more than the needed 24.000 ticks of the GameTime ;)
        //                 |--------red--------| |---green---|
        float timeOffset = (iBaseColor.r * 256.0 + iBaseColor.g) / 24000.0;

        float seconds = (GameTime - timeOffset) * 1200.0 * ANIMATED_LOGO_TIME_SCALE;

        fragColor = animatedLogoEasing(seconds - color.g * 10.0) > color.r ? vec4(LOGO_COLOR, color.a * vertexColor.a) : vec4(0.0);
        return;
    }
}
