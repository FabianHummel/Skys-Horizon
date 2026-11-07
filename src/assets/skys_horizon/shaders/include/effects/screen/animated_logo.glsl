#ifndef SKYS_HORIZON_EFFECTS_SCREEN_ANIMATED_LOGO_GLSL
#define SKYS_HORIZON_EFFECTS_SCREEN_ANIMATED_LOGO_GLSL

#ifdef VSH

void animated_logo_vertex(inout TextVertex v) {
    v.pos.y -= 30.0;
}

#endif

#ifdef FSH

float animatedLogoEasing(float x) {
    return x < 1.0 ? x < 0.5 ? 4.0 * x * x * x : 1.0 - pow(-2.0 * x + 2.0, 3.0) / 2.0 : 1.0;
}

bool animated_logo_fragment(TextFragment f, out vec4 color) {
    const float ANIMATED_LOGO_TIME_SCALE = 0.4;
    const vec3 LOGO_COLOR = vec3(0.05, 0.05, 0.05);

    vec4 texColor = texture(Sampler0, f.uv);
    if (texColor.a < 0.1) {
        discard;
    }

    // - Red channel has a configurable time scale (how long it takes to go from r=0 to r=255)
    // - Green channel is the tick-offset (g=255 -> 10s delay)
    // - Blue channel is currently unused
    ivec4 iBaseColor = ivec4(f.baseColor * 255.0);

    // Value from t=0 to t=24.000 to offset the GameTime.
    // Used to programmatically start the animation.
    // The lower 8 bits (red) and upper 8 bits (green) = 65.536 values
    //  which is more than the needed 24.000 ticks of the GameTime ;)
    float timeOffset = (iBaseColor.g * 256.0 + iBaseColor.b) / 24000.0;

    float seconds = (GameTime - timeOffset) * 1200.0 * ANIMATED_LOGO_TIME_SCALE;

    color = animatedLogoEasing(seconds - texColor.g * 10.0) > texColor.r ? vec4(LOGO_COLOR, texColor.a * f.vertexColor.a) : vec4(0.0);
    return true;
}

#endif

#endif
