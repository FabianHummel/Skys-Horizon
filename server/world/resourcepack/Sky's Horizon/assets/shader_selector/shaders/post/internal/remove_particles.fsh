#version 150

#moj_import <shader_selector:marker_settings.glsl>

uniform sampler2D ParticlesSampler;

layout(std140) uniform SamplerInfo {
    vec2 OutSize;
    vec2 InSize;
};

in vec2 texCoord;

out vec4 fragColor;

void main() {
    ivec2 iCoord = ivec2(gl_FragCoord.xy);
    fragColor = texture(ParticlesSampler, texCoord);
    ivec4 iColor = ivec4(round(fragColor * 255.));
    if (false
        #define ADD_MARKER(channel, id, op) || MARKER_POS(channel) == iCoord && iColor.ra == ivec2(id, MARKER_ALPHA)
        LIST_MARKERS
    ) {
        fragColor = texture(ParticlesSampler, texCoord + vec2(1./OutSize.x, 0.0));
    }
}
