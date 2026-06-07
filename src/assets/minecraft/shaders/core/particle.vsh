#version 150

#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:projection.glsl>
#moj_import <minecraft:globals.glsl>

in vec3 Position;
in vec2 UV0;
in vec4 Color;
in ivec2 UV2;

uniform sampler2D Sampler0;
uniform sampler2D Sampler2;

out vec3 Pos;
out float sphericalVertexDistance;
out float cylindricalVertexDistance;
out vec2 texCoord0;
out vec4 vertexColor;
out vec4 baseColor;

// ShaderSelector
#moj_import <shader_selector:marker_settings.glsl>
#moj_import <shader_selector:utils.glsl>

flat out int isMarker;
flat out ivec4 iColor;

// Debug Text
flat out int isDebugMarker;
out vec2 corner;

#define SKYS_HORIZON_PARTICLE_SHADER

#define VSH

// Sky's Horizon
#moj_import <skys_horizon:main.glsl>

#undef VSH

void main() {
    Pos = Position;
    baseColor = Color;

    // ShaderSelector
    #moj_import <shader_selector:main.vsh>

    // Sky's Horizon
    #moj_import <skys_horizon:main.vsh>

    gl_Position = ProjMat * ModelViewMat * vec4(Pos, 1.0);

    // Debug Text
    #moj_import <debug_text:main.vsh>

    sphericalVertexDistance = fog_spherical_distance(Pos);
    cylindricalVertexDistance = fog_cylindrical_distance(Pos);
    texCoord0 = UV0;
    vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
}
