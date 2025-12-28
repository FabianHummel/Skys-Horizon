iColor = ivec4(round(Color * 255.));
isMarker = int(iColor.a == MARKER_ALPHA);
ivec2 markerPos = ivec2(0, 0);
if (isMarker == 1) {
    isMarker = 0;
    #define ADD_MARKER(channel, id, op) if (iColor.a == MARKER_ALPHA) {isMarker = 1; markerPos = MARKER_POS(channel);}
    LIST_MARKERS
}
if (isMarker == 1 && (markerPos.x + markerPos.y) % 2 == 0) {
    vec2 markerSize = 2.0 / ScreenSize;
    gl_Position = vec4(-1 + (vec2(markerPos) + corners[gl_VertexID % 4]) * markerSize, 0.0, 1.0);
    sphericalVertexDistance = 0.0;
    cylindricalVertexDistance = 0.0;
    texCoord0 = vec2(0.0);
    vertexColor = vec4(0.0);
    return;
}
