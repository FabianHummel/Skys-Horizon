const int NUM_SPACEWARP_ROTATION_OFFSETS = 8;

const vec3[] spaceWarpRotations = vec3[](
    vec3(0.0, 0.0, 0.0),
    vec3(0.0, 0.0, 1.0),
    vec3(0.0, 1.0, 0.0),
    vec3(0.0, 1.0, 1.0),
    vec3(1.0, 0.0, 0.0),
    vec3(1.0, 0.0, 1.0),
    vec3(1.0, 1.0, 0.0),
    vec3(1.0, 1.0, 1.0)
);

vec3 applySpaceWarp(vec3 dir, float intensity, vec3 color) {
    const float speed = 1000.0;
    const float density = 500.0;
    const float compression = 0.3;
    const float trailSize = 20.0;
    const float brightness = 5.0;
    const float centerSize = 1.0;
    const float centerEdge = 0.6;

    // Make radial coordinates
    float dist = length(dir.xy);
    float mask = smoothstep(centerSize - centerEdge, centerSize, dist);
    float angle = atan(dir.y, dir.x);
    vec2 uv;
    uv.x = angle / PI * density;
    uv.y = dir.z / dist;

    // Apply warp effect (raindrops)
    float time = GameTime * speed * 0.2;

    vec2 duv = vec2(floor(uv.x), uv.y) * compression;
    float offset = sin(duv.x);
    float fall = cos(duv.x * 30.0);
    float trail = mix(100.0, trailSize, fall);

    float drop = fract(duv.y + time * fall + offset) * trail;
    drop = 1.0 / drop;
    drop = smoothstep(0.0, 1.0, drop * drop);
    drop = sin(drop * PI) * fall * brightness;

    float shape = sin(fract(uv.x) * PI);
    drop *= shape * shape;

    return color * drop * mask;
}
