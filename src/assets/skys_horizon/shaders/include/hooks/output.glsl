#ifndef SKYS_HORIZON_HOOKS_OUTPUT_GLSL
#define SKYS_HORIZON_HOOKS_OUTPUT_GLSL

// Writes a fully shaded custom color while still taking part in OIT; requires minecraft:oit.glsl and fragColor
void sh_emit(vec4 color) {
    #if defined(OIT_ALPHA_ONLY)
    executeAlphaOnlyPhase(gl_FragCoord.z, color.a);
    #elif defined(OIT_ACCUMULATE)
    fragColor = sampleColorForAccumulation(color);
    #else
    fragColor = color;
    #endif
}

#endif
