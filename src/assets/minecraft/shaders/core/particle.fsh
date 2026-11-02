#version 330
#extension GL_ARB_separate_shader_objects : require

#include <minecraft:fog.glsl>
#include <minecraft:dynamictransforms.glsl>
#include <minecraft:globals.glsl>
#include <minecraft:oit.glsl>
#include <debug_text:draw_text.glsl>

uniform sampler2D Sampler0;

layout(location = 0) in float sphericalVertexDistance;
layout(location = 1) in float cylindricalVertexDistance;
layout(location = 2) in vec2 texCoord0;
layout(location = 3) in vec4 vertexColor;

layout(location = 4) in vec3 Pos;
layout(location = 5) in vec4 baseColor;

#ifndef OIT_ALPHA_ONLY
layout(location = 0) out vec4 fragColor;
#else
// Alpha-only OIT passes have no color output; custom effects that write it simply skip transmittance
vec4 fragColor;
#endif

// ShaderSelector
layout(location = 6) flat in int isMarker;
layout(location = 7) flat in ivec4 iColor;

// Debug Text
layout(location = 8) flat in int isDebugMarker;
layout(location = 9) in vec2 corner;

#define SKYS_HORIZON_PARTICLE_SHADER

#define FSH

// Sky's Horizon
#include <skys_horizon:main.glsl>

#undef FSH

vec4 calculateFinalColor(vec4 color) {
    #ifdef OIT_ACCUMULATE
    color = sampleColorForAccumulation(color);
    vec4 fogColor = vec4(FogColor.rgb * color.a, FogColor.a);
    #else
    vec4 fogColor = FogColor;
    #endif
    return apply_fog(color, sphericalVertexDistance, cylindricalVertexDistance, FogEnvironmentalStart, FogEnvironmentalEnd, FogRenderDistanceStart, FogRenderDistanceEnd, fogColor);
}

void main() {
    // Debug Text
    #include <debug_text:main.fsh.glsl>

    // ShaderSelector
    #include <shader_selector:main.fsh.glsl>

    // Sky's Horizon
    #include <skys_horizon:main.fsh.glsl>

    // Vanilla code
    vec4 color = texture(Sampler0, texCoord0) * vertexColor * ColorModulator;
    if (color.a < 0.1) {
        discard;
    }
    #ifdef OIT_ALPHA_ONLY
    executeAlphaOnlyPhase(gl_FragCoord.z, color.a);
    #else
    fragColor = calculateFinalColor(color);
    #endif
}
