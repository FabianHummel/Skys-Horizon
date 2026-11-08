layout(location = 4) flat in int isMarker;
layout(location = 5) flat in ivec4 iColor;
layout(location = 6) flat in ivec2 markerPixel;

bool ss_fragment()
{
    if (isMarker != 1) {
        return false;
    }

    // Output the marker color only at its exact target pixel.
    // The marker is written with alpha 1.0 so the engine's OIT pipeline treats it
    // as a fully opaque fragment (alpha > OIT_FULLY_OPAQUE_ALPHA) and composites it
    // straight into minecraft:main without fog/accumulation tinting. The data
    // pipeline (post_effect/end_of_frame.json) then reads it back out of main.
    if (ivec2(gl_FragCoord.xy) == markerPixel) {
        #ifdef OIT_ALPHA_ONLY
        executeAlphaOnlyPhase(gl_FragCoord.z, 1.0);
        #else
        fragColor = vec4(iColor.rgb, 255) / 255.0;
        #endif
    } else {
        discard;
    }
    return true;
}
