#version 330
#extension GL_ARB_separate_shader_objects : require

#include <minecraft:light.glsl>
#include <minecraft:fog.glsl>
#include <minecraft:dynamictransforms.glsl>
#include <minecraft:projection.glsl>
#include <minecraft:globals.glsl>
#include <minecraft:oit.glsl>

uniform sampler2D Sampler0;

#ifdef GLINT
uniform sampler2D GlintSampler;
#endif

#ifndef OIT_ALPHA_ONLY
layout(location = 0) in float sphericalVertexDistance;
layout(location = 1) in float cylindricalVertexDistance;
#endif
layout(location = 2) in vec4 vertexColor;
#ifndef OIT_ALPHA_ONLY
layout(location = 3) in vec4 lightMapColor;
layout(location = 4) in vec4 overlayColor;
#endif
layout(location = 5) in vec2 texCoord;
#ifdef GLINT
layout(location = 6) in vec2 texCoordGlint;
#endif

// Sky's Horizon
layout(location = 7) in vec3 Pos;
layout(location = 8) in vec2 atlasSize;
layout(location = 9) in vec4 baseColor;

#ifndef OIT_ALPHA_ONLY
layout(location = 0) out vec4 fragColor;
#else
// Alpha-only OIT passes have no color output; custom effects that write it simply skip transmittance
vec4 fragColor;
#endif

#define SKYS_HORIZON_SPACE_SHADER
#define SKYS_HORIZON_ENTITY_SHADER
#define SKYS_HORIZON_SCENE_SHADER

#define FSH

// objmc
#include <objmc:main.glsl>

// Sky's Horizon
#include <skys_horizon:main.glsl>
#include <skys_horizon:screen.glsl>

#undef FSH

#ifndef OIT_ALPHA_ONLY
vec4 calculateFinalColor(vec4 color) {
    color.rgb = mix(overlayColor.rgb, color.rgb, overlayColor.a);
    color *= lightMapColor;

    #ifdef GLINT
    vec4 glintColor = GlintAlpha * texture(GlintSampler, texCoordGlint);
    color.rgb += glintColor.rgb * glintColor.rgb;
    #endif

    // Sky's Horizon
    color = applyPosterization(color);

    #ifdef OIT_ACCUMULATE
    color = sampleColorForAccumulation(color);
    vec4 fogColor = vec4(FogColor.rgb * color.a, FogColor.a);
    #else
    vec4 fogColor = FogColor;
    #endif

    return apply_fog(color, sphericalVertexDistance, cylindricalVertexDistance, FogEnvironmentalStart, FogEnvironmentalEnd, FogRenderDistanceStart, FogRenderDistanceEnd, fogColor);
}
#endif

void main() {
    vec4 color = texture(Sampler0, texCoord);

    // Sky's Horizon
    #include <skys_horizon:main.fsh.glsl>

    #ifdef ALPHA_CUTOUT
    if (color.a < ALPHA_CUTOUT) {
        discard;
    }
    #endif

    // Sky's Horizon
    if (isSpaceObject == true) {
        return;
    }

    color *= vertexColor * ColorModulator;

    #ifdef GLINT
    color.a = max(color.a, GlintAlpha);
    #endif

    #ifdef OIT_ALPHA_ONLY
    executeAlphaOnlyPhase(gl_FragCoord.z, color.a);
    #else
    fragColor = calculateFinalColor(color);
    #endif
}
