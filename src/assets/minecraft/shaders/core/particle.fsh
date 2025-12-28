#version 150

#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:globals.glsl>
#moj_import <debug_text:draw_text.glsl>

uniform sampler2D Sampler0;

in float sphericalVertexDistance;
in float cylindricalVertexDistance;
in vec2 texCoord0;
in vec4 vertexColor;

out vec4 fragColor;

// ShaderSelector
flat in int isMarker;
flat in ivec4 iColor;

// Debug Text
flat in int isDebugMarker;
in vec2 corner;

void main() {
    // Debug Text
    #moj_import <debug_text:main.fsh>

    // ShaderSelector
    if (isMarker == 1) {
        fragColor = vec4(iColor.rgb, 255) / 255.0;
        return;
    }

    // Vanilla code
    vec4 color = texture(Sampler0, texCoord0) * vertexColor * ColorModulator;
    if (color.a < 0.1) {
        discard;
    }
    fragColor = apply_fog(color, sphericalVertexDistance, cylindricalVertexDistance, FogEnvironmentalStart, FogEnvironmentalEnd, FogRenderDistanceStart, FogRenderDistanceEnd, FogColor);
}
