#version 150

#moj_import <minecraft:light.glsl>
#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:projection.glsl>
#moj_import <minecraft:globals.glsl>

uniform sampler2D Sampler0;

in float sphericalVertexDistance;
in float cylindricalVertexDistance;
in vec4 baseColor;
in vec4 vertexColor;
in vec4 lightColor;
in vec4 overlayColor;
in vec2 texCoord;
in vec3 Pos;

flat in int isCustom;

out vec4 fragColor;

#moj_import <skys_horizon:utils.glsl>
#moj_import <skys_horizon:space.glsl>

void main() {
    vec4 color = texture(Sampler0, texCoord);

    // Sky's Horizon
    if (textureAlphaEquals(254)) {
        vec3 viewDir = normalize(Pos);
        vec3 spaceColor = vec3(1.0);
        vec3 final = getSpaceWarp(viewDir, baseColor.r, spaceColor);
        fragColor = vec4(final, 1.0);
        return;
    }
    if (textureAlphaEquals(253)) {
        fragColor = vec4(1.0, 0.0, 0.0, 1.0);
        return;
    }

    // objmc
    #moj_import <objmc:light.glsl>

    if (color.a < 0.1) {
        discard;
    }

    fragColor = apply_fog(color, sphericalVertexDistance, cylindricalVertexDistance, FogEnvironmentalStart, FogEnvironmentalEnd, FogRenderDistanceStart, FogRenderDistanceEnd, FogColor);
}
