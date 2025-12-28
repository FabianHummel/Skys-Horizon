isDebugMarker = 0;
if (ivec3(Color.rgb * 255.) == ivec3(1, 2, 3)) {
    isDebugMarker = 1;
    corner = corners[gl_VertexID % 4] * vec2(1.0, .25) + vec2(0, .75);
    gl_Position = vec4(corner * 2. - 1., 0, 1);
}
