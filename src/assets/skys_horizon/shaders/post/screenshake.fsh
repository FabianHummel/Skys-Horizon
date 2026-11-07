#version 330
#extension GL_ARB_separate_shader_objects : require

uniform sampler2D MainSampler;
uniform sampler2D DataSampler;

#include <minecraft:globals.glsl>

#include <shader_selector:marker_settings.glsl>
#include <shader_selector:utils.glsl>
#include <shader_selector:data_reader.glsl>

layout(location = 0) in vec2 texCoord;

layout(location = 0) out vec4 fragColor;

float random(vec2 uv)
{
    return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453123);
}

vec2 getScreenShake(vec2 uv, float intensity, float time)
{
    if (intensity <= 0.0) return uv;
    float val1 = random(vec2(0.25, 0.25) + time);
    float val2 = random(vec2(0.75, 0.75) + time);
    val1 = clamp(val1, 0.0, 1.0);
    val2 = clamp(val2, 0.0, 1.0);
    vec2 shake = vec2(val1, val2) * intensity * 0.025;
    return uv + shake;
}

void main()
{
    float time = GameTime * 1200.0;
    float screenShakeIntensity = readChannel(SCREENSHAKE_CHANNEL);
    vec2 uv = getScreenShake(texCoord, screenShakeIntensity, time);
    fragColor = texture(MainSampler, uv);
}
