#version 330

uniform sampler2D MainSampler;
uniform sampler2D MainDepthSampler;
uniform sampler2D PrevSampler;
uniform sampler2D DataSampler;

#moj_import <minecraft:globals.glsl>

#moj_import <shader_selector:marker_settings.glsl>
#moj_import <shader_selector:utils.glsl>
#moj_import <shader_selector:data_reader.glsl>

in vec2 texCoord;

out vec4 fragColor;

vec2 getDownscaledResolution(vec2 uv, float aspectRatio)
{
    const int TARGET_RESOLUTION = 1080;
    vec2 targetResolution = vec2(TARGET_RESOLUTION, TARGET_RESOLUTION * aspectRatio);
    return floor(uv * targetResolution) / targetResolution;
}

vec4 getPhosphor(vec4 current, vec2 uv, float intensity)
{
    vec4 prev = texture(PrevSampler, uv);
    return vec4(max(prev.rgb * intensity, current.rgb), 1.0);
}

void main()
{
    vec2 uv = texCoord;

    //float downscaledQuality = readChannel(DOWNSCALE_CHANNEL);
    //uv = getDownscaledResolution(uv, ScreenSize.y / ScreenSize.x);

    vec4 color = texture(MainSampler, uv);

    float intensity = readChannel(PHOSPHOR_CHANNEL);
    color = getPhosphor(color, uv, intensity);

    fragColor = color;
}
