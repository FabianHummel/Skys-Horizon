#if 0
void main()
#endif
{
    isSkyboxMarker = 0;

    if (markerColor.a == STATIONARY_SKYBOX_ALPHA) {
        isSkyboxMarker = 1;
    }

    if (markerColor.a == SPACE_SKYBOX_ALPHA) {
        isSkyboxMarker = 1;

        // hide all other sides of the cube, as we only need 4 verts to display a screenquad
        if (gl_VertexID >= 4) {
            gl_Position = vec4(0.0);
            return;
        }

        vec2 cornerPos = SCREEN_CORNERS[gl_VertexID % 4];
        gl_Position = vec4(cornerPos, 1.0, 2.0);

        vec4 rotation = decodeRotationPrecise();
        rotation = vec4(-rotation.xyz, rotation.w);

        float aspect = ScreenSize.x / ScreenSize.y;
        cornerPos.x *= aspect;

        vec3 pos = vec3(cornerPos, -1.0);
        Pos = normalize(rotate(pos, rotation));

        return;
    }
}
