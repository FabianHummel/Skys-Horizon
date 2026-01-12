#version 150

#moj_import <minecraft:light.glsl>
#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:projection.glsl>
#moj_import <minecraft:globals.glsl>

uniform sampler2D Sampler0;

in vec3 Pos;
in vec2 texCoord;
in vec4 overlayColor;
in vec4 lightColor;
in vec4 vertexColor;
in vec4 baseColor;
in float sphericalVertexDistance;
in float cylindricalVertexDistance;

out vec4 fragColor;

#define FSH

#moj_import <objmc:main.glsl>
#moj_import <skys_horizon:main.glsl>

#undef FSH

void main() {
    vec4 color = texture(Sampler0, texCoord);

    // objmc
    #moj_import <objmc:main.fsh>

    // Sky's Horizon
    #moj_import <skys_horizon:main.fsh>

    // Vanilla code
    if (color.a < 0.1) {
        discard;
    }

    fragColor = apply_fog(color, sphericalVertexDistance, cylindricalVertexDistance, FogEnvironmentalStart, FogEnvironmentalEnd, FogRenderDistanceStart, FogRenderDistanceEnd, FogColor);
}
