#if 0
void main()
#endif
{
    isSkyboxMarker = 0;

    if (uvMarkerColor.a == STATIONARY_SKYBOX_ALPHA) {
        isSkyboxMarker = 1;
    }

    if (uvMarkerColor.a == SPACE_SKYBOX_ALPHA) {
        isSkyboxMarker = 1;

        // hide all other sides of the cube, as we only need 4 verts to display a screenquad
        if (gl_VertexID >= 4) {
            gl_Position = vec4(0.0);
            return;
        }

        vec2 cornerPos = SCREEN_CORNERS[gl_VertexID % 4];
        gl_Position = vec4(cornerPos, 1.0, 1.0);

        vec3 rotation = decodeRotationPrecise();
        mat3 skyboxMat = applyRotation(-rotation);

        float aspect = ScreenSize.x / ScreenSize.y;
        cornerPos.x *= aspect;
        Pos = normalize(skyboxMat * vec3(cornerPos, -1.0));

        return;
    }
}
