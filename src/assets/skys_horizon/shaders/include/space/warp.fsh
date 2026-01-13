if (isWarpMarker()) {
    const float PI = 3.1415926535897932;

    const float speed = 500.0;
    const float density = 200.0;
    const float compression = 0.2;
    const float trailSize = 20.0;
    const float brightness = 10.0;
    const float centerSize = 1.0;
    const float centerEdge = 0.6;

    vec4 color = vec4(1.0, 1.0, 1.0, spaceWarpOpacity);

    // Make radial coordinates
    vec3 dir = normalize(Pos);
    float dist = length(dir.xy);
    float angle = atan(dir.y, dir.x);
    vec2 uv;
    uv.x = angle / PI * density;
    uv.y = dir.z / -dist;

    // Apply warp effect (raindrops)
    float time = GameTime * speed;

    vec2 duv = vec2(floor(uv.x), uv.y) * compression;
    float offset = sin(duv.x);
    float fall = cos(duv.x * 30.0);
    float trail = mix(100.0, trailSize, fall);

    float drop = fract(duv.y + time * fall + offset) * trail;
    drop = 1.0 / drop;
    drop = smoothstep(0.0, 1.0, drop * drop);
    drop = sin(drop / PI / 2.0) * fall * brightness;

    float shape = sin(fract(uv.x) * PI);
    drop *= shape * shape;

    float mask = smoothstep(centerSize - centerEdge, centerSize, dist);
    vec4 final = color * drop * mask;

    if (final.a < 0.1) {
        discard;
    }

    fragColor = final;
    return;
}
