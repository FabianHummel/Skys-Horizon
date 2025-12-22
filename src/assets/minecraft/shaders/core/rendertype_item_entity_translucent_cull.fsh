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
in vec2 texCoord2;
in vec3 Pos;
in float transition;

flat in int isCustom;
flat in int isGUI;
flat in int isHand;
flat in int noshadow;

out vec4 fragColor;

// Sky's Horizon
const float speed = 1000.0;
const float density = 500.0;
const float compression = 0.3;
const float trailSize = 20.0;
const float brightness = 5.0;
const float centerSize = 1.0;
const float centerEdge = 0.6;
const float PI = 3.14159265359;

#moj_import <skys_horizon:utils.glsl>

vec3 getSpaceWarp(vec3 dir, float intensity, vec3 color) {
    // Make radial coordinates
    float dist = length(dir.xy);
    float mask = smoothstep(centerSize - centerEdge, centerSize, dist);
    float angle = atan(dir.y, dir.x);
    vec2 uv;
    uv.x = angle / PI * density;
    uv.y = dir.z / dist;

    // Apply warp effect (raindrops)
    float time = GameTime * speed * intensity;

    vec2 duv = vec2(floor(uv.x), uv.y) * compression;
    float offset = sin(duv.x);
    float fall = cos(duv.x * 30.0);
    float trail = mix(100.0, trailSize, fall);

    float drop = fract(duv.y + time * fall + offset) * trail;
    drop = 1.0 / drop;
    drop = smoothstep(0.0, 1.0, drop * drop);
    drop = sin(drop * PI) * fall * brightness;

    float shape = sin(fract(uv.x) * PI);
    drop *= shape * shape;

    return color * drop * mask;
}

void main() {
    vec4 color = mix(texture(Sampler0, texCoord), texture(Sampler0, texCoord2), transition);

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
    #define ENTITY
    #moj_import<objmc:light.glsl>

    if (color.a < 0.1) {
        discard;
    }

    fragColor = apply_fog(color, sphericalVertexDistance, cylindricalVertexDistance, FogEnvironmentalStart, FogEnvironmentalEnd, FogRenderDistanceStart, FogRenderDistanceEnd, FogColor);
}
