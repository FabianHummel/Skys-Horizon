#version 330

#moj_import <minecraft:light.glsl>
#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:projection.glsl>
#moj_import <minecraft:globals.glsl>

uniform sampler2D Sampler0;

in vec3 Pos;
in vec2 texCoord;
in vec2 atlasSize;
in vec4 overlayColor;
in vec4 lightMapColor;
in vec4 vertexColor;
in vec4 baseColor;
in float sphericalVertexDistance;
in float cylindricalVertexDistance;

out vec4 fragColor;

#define SKYS_HORIZON_SPACE_SHADER
#define SKYS_HORIZON_ENTITY_SHADER
#define SKYS_HORIZON_SCENE_SHADER

#define FSH

// objmc
#moj_import <objmc:main.glsl>

// Sky's Horizon
#moj_import <skys_horizon:main.glsl>

#undef FSH

void main() {
    vec4 color = texture(Sampler0, texCoord);

    // Sky's Horizon
    #moj_import <skys_horizon:main.fsh>

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
    color.rgb = mix(overlayColor.rgb, color.rgb, overlayColor.a);
    color *= lightMapColor;

    fragColor = apply_fog(color, sphericalVertexDistance, cylindricalVertexDistance, FogEnvironmentalStart, FogEnvironmentalEnd, FogRenderDistanceStart, FogRenderDistanceEnd, FogColor);
}
