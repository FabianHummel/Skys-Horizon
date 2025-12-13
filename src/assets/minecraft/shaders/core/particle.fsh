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
    if (isDebugMarker == 1) {
        float scale = 300.;

        vec2 resolution = gl_FragCoord.xy / corner;
        vec2 uv = gl_FragCoord.xy / resolution.x * scale;
        uv.y -= resolution.y / resolution.x * scale;

        uv -= vec2(1., -6.);
        float state = 0.0;
        drawGlobals(state, uv);
        if (state == 0.0) discard;

        fragColor = vec4(1);
        return;
    }
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
