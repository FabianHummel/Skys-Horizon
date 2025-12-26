vec3 getSpaceWarp(vec3 dir, float intensity, vec3 color) {
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
    float time = GameTime * speed * intensity;

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

mat4 getPlanetModelViewMat(mat4 mvm) {
    float yaw = -atan(mvm[0].z, mvm[0].x);

    return mat4(
        vec4(cos(yaw), 0.0, -sin(yaw), 0.0),
        vec4(0.0,      1.0,  0.0,      0.0),
        vec4(sin(yaw), 0.0,  cos(yaw), 0.0),
        mvm[3]
    );
}

vec3 getPlanetRotation(vec3 data) {
    ivec3 c = ivec3(data * 255.0);
    // high/low 4-bit
    int pitch12 = (c.r >> 4) * 256 + c.g; // high 4 bits of red
    float pitch = -float(pitch12) * (2.0 * PI / 4096.0);
    int roll12 = (c.r & 15) * 256 + c.b; // low 4 bits of red
    float roll = float(roll12)  * (2.0 * PI / 4096.0);

    return vec3(pitch, 0.0, roll);
}
