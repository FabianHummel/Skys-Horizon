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
#moj_import <shader_selector:utils.glsl>

flat out int isMarker;
flat out ivec4 iColor;

// Debug Text
flat out int isDebugMarker;
out vec2 corner;

void main() {
    // Vanilla code
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    // Debug Text
    #moj_import <debug_text:main.vsh>

    // ShaderSelector
    #moj_import <shader_selector:main.glsl>

    // Vanilla code
    sphericalVertexDistance = fog_spherical_distance(Position);
    cylindricalVertexDistance = fog_cylindrical_distance(Position);
    texCoord0 = UV0;
    vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
}
