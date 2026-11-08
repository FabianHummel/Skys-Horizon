#include <shader_selector:marker_settings.glsl>
#include <shader_selector:utils.glsl>

layout(location = 4) flat out int isMarker;
layout(location = 5) flat out ivec4 iColor;
layout(location = 6) flat out ivec2 markerPixel;

const vec2[] corners = vec2[](
        vec2(0.0, 1.0),
        vec2(0.0, 0.0),
        vec2(1.0, 0.0),
        vec2(1.0, 1.0)
    );

bool ss_vertex(inout vec4 position)
{
    iColor = ivec4(round(Color * 255.));
    isMarker = int(iColor.a == MARKER_RED);
    ivec2 markerPos = ivec2(0, 0);
    markerPixel = ivec2(0);

    if (isMarker == 1) {
        isMarker = 0;
        #define ADD_MARKER(row, green, alpha, op, rate) if (ivec2(green, alpha) == iColor.ga) {isMarker = 1; markerPos = MARKER_POS(row);}
        LIST_MARKERS
    }

    if (isMarker == 1 && (markerPos.x + markerPos.y) % 2 == 0) {
        markerPixel = markerPos;
        // Sodium-safe: fixed NDC quad covering all marker pixel positions.
        // MARKER_POS values reach max ~(6,4). A 0.03 NDC quad covers ~19px at 720p.
        // Fragment shader uses gl_FragCoord to output at the exact target pixel.
        vec2 quadSize = vec2(0.03);
        // z=1.0: nearest depth under the reversed depth buffer used since 26.2,
        // so the marker always passes the depth test.
        position = vec4(-1.0 + corners[gl_VertexIndex % 4] * quadSize, 1.0, 1.0);
        return true;
    }

    return false;
}
