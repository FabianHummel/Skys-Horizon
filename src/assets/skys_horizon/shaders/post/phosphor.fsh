#version 330

uniform sampler2D MainSampler;
uniform sampler2D PrevSampler;
uniform sampler2D DataSampler;

#moj_import <minecraft:globals.glsl>

#moj_import <shader_selector:marker_settings.glsl>
#moj_import <shader_selector:utils.glsl>
#moj_import <shader_selector:data_reader.glsl>

in vec2 texCoord;

out vec4 fragColor;

vec4 getPhosphor(vec4 current, vec2 uv, float intensity)
{
    if (intensity <= 0.0) return current;
    vec4 prev = texture(PrevSampler, uv);
    return vec4(max(prev.rgb * intensity, current.rgb), 1.0);
}

void main()
{
    float intensity = readChannel(PHOSPHOR_CHANNEL);
    fragColor = getPhosphor(color, texCoord, intensity);
}
