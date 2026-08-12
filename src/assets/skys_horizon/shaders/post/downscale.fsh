#version 330

uniform sampler2D MainSampler;
uniform sampler2D DataSampler;

layout(std140) uniform DownscaleConfig {
    int TargetWidth;
};

#moj_import <minecraft:globals.glsl>

#moj_import <shader_selector:marker_settings.glsl>
#moj_import <shader_selector:utils.glsl>
#moj_import <shader_selector:data_reader.glsl>

in vec2 texCoord;

out vec4 fragColor;

vec2 getDownscaledResolution(vec2 uv, float intensity)
{
    if (intensity <= 0) return uv;
    float aspect = ScreenSize.y / ScreenSize.x;
    vec2 newResolution = mix(ScreenSize, vec2(TargetWidth, TargetWidth * aspect), intensity);
    return floor(uv * newResolution) / newResolution;
}

void main()
{
    vec2 uv = texCoord;
    float intensity = readChannel(DOWNSCALE_CHANNEL);
    uv = getDownscaledResolution(uv, intensity);
    fragColor = texture(MainSampler, uv);
}
