#version 330
#extension GL_ARB_separate_shader_objects : require

uniform sampler2D MainSampler;
uniform sampler2D MainDepthSampler;
uniform sampler2D PrevSampler;
uniform sampler2D DataSampler;

#include <minecraft:globals.glsl>

#include <shader_selector:marker_settings.glsl>
#include <shader_selector:utils.glsl>
#include <shader_selector:data_reader.glsl>

#include <skys_horizon:lib/markers.glsl>

layout(location = 0) in vec2 texCoord;

layout(location = 0) out vec4 fragColor;

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

float getEdge(vec2 resolution, vec2 uv, vec2 point)
{
    const vec3 luma = vec3(0.299, 0.587, 0.114);
    const float intensity = 0.6;
    return dot(texture(MainSampler, uv + vec2(1.0 / resolution.x, 1.0 / resolution.y) * point).xyz, luma) * intensity;
}

vec4 getSobel(vec4 baseColor, vec2 uv)
{
    const vec4 DARK_LINE_COLOR = vec4(vec3(20, 17, 19) / 255.0, 1.0);
    const vec4 LIGHT_LINE_COLOR = vec4(vec3(117, 111, 108) / 255.0, 1.0);
    vec2 resolution = textureSize(MainSampler, 0);

    // kernel definition (in glsl matrices are filled in column-major order)
    const mat3 Gx = mat3(-1, -2, -1, 0, 0, 0, 1, 2, 1); // x direction kernel
    const mat3 Gy = mat3(-1, 0, 1, -2, 0, 2, -1, 0, 1); // y direction kernel

    // fetch the 3x3 neighbourhood of a fragment

    // first column
    float tx0y0 = getEdge(resolution, uv, vec2(-1, -1));
    float tx0y1 = getEdge(resolution, uv, vec2(-1, 0));
    float tx0y2 = getEdge(resolution, uv, vec2(-1, 1));

    // second column
    float tx1y0 = getEdge(resolution, uv, vec2(0, -1));
    float tx1y1 = getEdge(resolution, uv, vec2(0, 0));
    float tx1y2 = getEdge(resolution, uv, vec2(0, 1));

    // third column
    float tx2y0 = getEdge(resolution, uv, vec2(1, -1));
    float tx2y1 = getEdge(resolution, uv, vec2(1, 0));
    float tx2y2 = getEdge(resolution, uv, vec2(1, 1));

    // gradient value in x direction
    float valueGx = Gx[0][0] * tx0y0 + Gx[1][0] * tx1y0 + Gx[2][0] * tx2y0 +
            Gx[0][1] * tx0y1 + Gx[1][1] * tx1y1 + Gx[2][1] * tx2y1 +
            Gx[0][2] * tx0y2 + Gx[1][2] * tx1y2 + Gx[2][2] * tx2y2;

    // gradient value in y direction
    float valueGy = Gy[0][0] * tx0y0 + Gy[1][0] * tx1y0 + Gy[2][0] * tx2y0 +
            Gy[0][1] * tx0y1 + Gy[1][1] * tx1y1 + Gy[2][1] * tx2y1 +
            Gy[0][2] * tx0y2 + Gy[1][2] * tx1y2 + Gy[2][2] * tx2y2;

    // magnitude of the total gradient
    float G = (valueGx * valueGx) + (valueGy * valueGy);
    float sobelValue = clamp(G, 0.0, 1.0);

    const vec3 luma = vec3(0.299, 0.587, 0.114);
    float baseLuminance = dot(baseColor.rgb, luma);

    return sobelValue > 0.05 ? baseLuminance < 0.5 ? DARK_LINE_COLOR : LIGHT_LINE_COLOR : baseColor;
}

void main()
{
    vec2 uv = texCoord;

    //float downscaledQuality = readChannel(DOWNSCALE_CHANNEL);
    //uv = getDownscaledResolution(uv, ScreenSize.y / ScreenSize.x);

    vec4 color = texture(MainSampler, uv);

    color = getSobel(color, uv);

    float intensity = readChannel(PHOSPHOR_CHANNEL);
    color = getPhosphor(color, uv, intensity);

    fragColor = color;
}
