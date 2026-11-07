#include <shader_selector:marker_settings.glsl>
#include <shader_selector:utils.glsl>

layout(location = 4) flat out int isMarker;
layout(location = 5) flat out ivec4 iColor;

bool ss_vertex(out vec3 Pos)
{
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
        Pos = vec3(-1 + (vec2(markerPos) + corners[gl_VertexIndex % 4]) * markerSize, 0.0);
        return true;
    }

    return false;
}
