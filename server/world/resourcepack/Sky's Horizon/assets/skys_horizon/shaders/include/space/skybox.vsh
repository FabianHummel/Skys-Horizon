if (isSkyboxMarker()) {
    // hide all other sides of the cube, as we only need 4 verts to display a screenquad
    if (gl_VertexID >= 4) {
        gl_Position = vec4(0.0);
        return;
    }

    vec2 cornerPos = skyboxCorners[gl_VertexID % 4];
    gl_Position = vec4(cornerPos, 1.0, 1.0);

    vec3 rotation = decodeRotation();
    mat3 skyboxMat = rotate(rotation);

    float aspect = ScreenSize.x / ScreenSize.y;
    // cornerPos.x *= aspect;
    Pos = normalize(skyboxMat * vec3(cornerPos, -1.0));
    // Pos.x /= aspect;

    return;
}
