if (isSkyboxMarker()) {
    vec3 rotation = decodeRotation();

    vec2 cornerPos = skyboxCorners[gl_VertexID % 4];
    gl_Position = vec4(cornerPos, 1.0, 1.0);

    float aspect = ScreenSize.x / ScreenSize.y;
    mat2 rot = mat2(cos(rotation.z), -sin(rotation.z),
                    sin(rotation.z),  cos(rotation.z));
    vec2 p = cornerPos;
    p.x *= aspect;
    p = rot * p;
    p = p * 0.5 + 0.5;
    p.x /= aspect;

    Pos = vec3(p, 0.0);
    return;
}
