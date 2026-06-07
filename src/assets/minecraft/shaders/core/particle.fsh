#version 150

#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:globals.glsl>
#moj_import <debug_text:draw_text.glsl>

uniform sampler2D Sampler0;

in vec3 Pos;
in float sphericalVertexDistance;
in float cylindricalVertexDistance;
in vec2 texCoord0;
in vec4 vertexColor;
in vec4 baseColor;

out vec4 fragColor;

// ShaderSelector
flat in int isMarker;
flat in ivec4 iColor;

// Debug Text
flat in int isDebugMarker;
in vec2 corner;

#define SKYS_HORIZON_PARTICLE_SHADER

#define FSH

// Sky's Horizon
#moj_import <skys_horizon:main.glsl>

#undef FSH

void main() {
    // Debug Text
    #moj_import <debug_text:main.fsh>

    // ShaderSelector
    #moj_import <shader_selector:main.fsh>

    // Sky's Horizon
    #moj_import <skys_horizon:main.fsh>

    // Vanilla code
    vec4 color = texture(Sampler0, texCoord0) * vertexColor * ColorModulator;
    if (color.a < 0.1) {
        discard;
    }
    fragColor = apply_fog(color, sphericalVertexDistance, cylindricalVertexDistance, FogEnvironmentalStart, FogEnvironmentalEnd, FogRenderDistanceStart, FogRenderDistanceEnd, FogColor);
}
