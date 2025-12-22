#version 150

#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:projection.glsl>
#moj_import <minecraft:globals.glsl>

in vec3 Position;
in vec2 UV0;
in vec4 Color;
in ivec2 UV2;

uniform sampler2D Sampler2;

out float sphericalVertexDistance;
out float cylindricalVertexDistance;
out vec2 texCoord0;
out vec4 vertexColor;

// ShaderSelector
#moj_import <shader_selector:marker_settings.glsl>

flat out int isMarker;
flat out ivec4 iColor;

// Debug Text
flat out int isDebugMarker;
out vec2 corner;

vec2[] corners = vec2[](
        vec2(0.0, 1.0),
        vec2(0.0, 0.0),
        vec2(1.0, 0.0),
        vec2(1.0, 1.0)
    );

void main() {
    // Vanilla (part 1)
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    // Debug Text
    isDebugMarker = 0;
    if (ivec3(Color.rgb * 255.) == ivec3(1, 2, 3)) {
        isDebugMarker = 1;
        corner = corners[gl_VertexID % 4] * vec2(1.0, .25) + vec2(0, .75);
        gl_Position = vec4(corner * 2. - 1., 0, 1);
    }

    // ShaderSelector
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
    // Vanilla (part 2)
    sphericalVertexDistance = fog_spherical_distance(Position);
    cylindricalVertexDistance = fog_cylindrical_distance(Position);
    texCoord0 = UV0;
    vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
}
