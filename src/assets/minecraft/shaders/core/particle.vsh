#version 330
#extension GL_ARB_separate_shader_objects : require

#include <minecraft:fog.glsl>
#include <minecraft:dynamictransforms.glsl>
#include <minecraft:projection.glsl>
#include <minecraft:sample_lightmap.glsl>
#include <minecraft:globals.glsl>

layout(location = 0) in vec3 Position;
layout(location = 1) in vec2 UV0;
layout(location = 2) in vec4 Color;
layout(location = 3) in ivec2 UV2;

uniform sampler2D Sampler0;
uniform sampler2D Sampler2;

layout(location = 0) out float sphericalVertexDistance;
layout(location = 1) out float cylindricalVertexDistance;
layout(location = 2) out vec2 texCoord0;
layout(location = 3) out vec4 vertexColor;

// ShaderSelector
#include <shader_selector:marker_settings.glsl>
#include <shader_selector:utils.glsl>

layout(location = 4) flat out int isMarker;
layout(location = 5) flat out ivec4 iColor;

// Debug Text
layout(location = 6) flat out int isDebugMarker;
layout(location = 7) out vec2 corner;

#define VSH

// Sky's Horizon
#include <skys_horizon:hooks/particle.glsl>

#undef VSH

void main() {
    vec3 Pos = Position;

    // ShaderSelector
    #include <shader_selector:main.vsh.glsl>

    // Sky's Horizon
    if (sh_particle_vertex(iColor, Pos)) {
        isMarker = 1;
    }

    gl_Position = ProjMat * ModelViewMat * vec4(Pos, 1.0);

    // Debug Text
    #include <debug_text:main.vsh.glsl>

    sphericalVertexDistance = fog_spherical_distance(Pos);
    cylindricalVertexDistance = fog_cylindrical_distance(Pos);
    texCoord0 = UV0;
    vertexColor = Color * sample_lightmap(Sampler2, UV2);
}
