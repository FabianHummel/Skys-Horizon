#version 330
#extension GL_ARB_separate_shader_objects : require

#include <minecraft:light.glsl>
#include <minecraft:fog.glsl>
#include <minecraft:dynamictransforms.glsl>
#include <minecraft:projection.glsl>
#include <minecraft:sample_lightmap.glsl>
#include <minecraft:globals.glsl>

layout(location = 0) in vec3 Position;
layout(location = 1) in vec4 Color;
layout(location = 2) in vec2 UV0;
layout(location = 3) in ivec2 UV1;
layout(location = 4) in ivec2 UV2;
#ifdef GLINT_SPECIAL
layout(location = 5) in vec2 UV3;
#endif
layout(location = 6) in vec3 Normal;

uniform sampler2D Sampler0;
#ifndef OIT_ALPHA_ONLY
uniform sampler2D Sampler1;
uniform sampler2D Sampler2;

layout(location = 0) out float sphericalVertexDistance;
layout(location = 1) out float cylindricalVertexDistance;
#endif
layout(location = 2) out vec4 vertexColor;
#ifndef OIT_ALPHA_ONLY
layout(location = 3) out vec4 lightMapColor;
layout(location = 4) out vec4 overlayColor;
#endif
layout(location = 5) out vec2 texCoord;
#ifdef GLINT
layout(location = 6) out vec2 texCoordGlint;
#endif

// Sky's Horizon (locations 10-21 are used by its modules, objmc must start at 22)
layout(location = 7) out vec3 Pos;
layout(location = 8) out vec2 atlasSize;
layout(location = 9) out vec4 baseColor;

#define SKYS_HORIZON_SPACE_SHADER
#define SKYS_HORIZON_ENTITY_SHADER
#define SKYS_HORIZON_SCENE_SHADER

#define VSH

// objmc
#include <objmc:main.glsl>

// Sky's Horizon
#include <skys_horizon:main.glsl>

#undef VSH

void main() {
    vertexColor = minecraft_mix_light(Light0_Direction, Light1_Direction, Normal, Color);
    #ifndef OIT_ALPHA_ONLY
    lightMapColor = sample_lightmap(Sampler2, UV2);
    overlayColor = texelFetch(Sampler1, UV1, 0);
    #endif

    // Sky's Horizon
    Pos = Position;
    texCoord = UV0;
    atlasSize = textureSize(Sampler0, 0);
    baseColor = Color;

    #ifdef GLINT
    #ifdef GLINT_SPECIAL
    texCoordGlint = (TextureMat * vec4(UV3, 0.0, 1.0)).xy;
    #else
    texCoordGlint = (TextureMat * vec4(UV0, 0.0, 1.0)).xy;
    #endif
    #endif

    // objmc
    #include <objmc:main.vsh.glsl>

    // Sky's Horizon
    #include <skys_horizon:main.vsh.glsl>

    gl_Position = ProjMat * ModelViewMat * vec4(Pos, 1.0);

    #ifndef OIT_ALPHA_ONLY
    sphericalVertexDistance = fog_spherical_distance(Pos);
    cylindricalVertexDistance = fog_cylindrical_distance(Pos);
    #endif
}
