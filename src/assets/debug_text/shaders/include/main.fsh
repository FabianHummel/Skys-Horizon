if (isDebugMarker == 1) {
    float scale = 300.;

    vec2 resolution = gl_FragCoord.xy / corner;
    vec2 uv = gl_FragCoord.xy / resolution.x * scale;
    uv.y -= resolution.y / resolution.x * scale;

    uv -= vec2(1., -6.);
    float state = 0.0;
    drawGlobals(state, uv);
    if (state == 0.0) discard;

    fragColor = vec4(1);
    return;
}
