#version 330

uniform sampler2D MainSampler;
uniform sampler2D MainDepthSampler;
uniform sampler2D DataSampler;

#moj_import <minecraft:globals.glsl>

#moj_import <shader_selector:marker_settings.glsl>
#moj_import <shader_selector:utils.glsl>
#moj_import <shader_selector:data_reader.glsl>

in vec2 texCoord;

out vec4 fragColor;

float random(vec2 uv)
{
    return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453123);
}

vec4 applyScreenShake(vec2 uv, float intensity, float time)
{
    if (intensity <= 0.0) {
        return texture(MainSampler, uv);
    }
    float val1 = random(vec2(0.25, 0.25) + time);
    float val2 = random(vec2(0.75, 0.75) + time);
    val1 = clamp(val1, 0.0, 1.0);
    val2 = clamp(val2, 0.0, 1.0);
    vec2 shake = vec2(val1, val2) * intensity * 0.025;
    return texture(MainSampler, uv + shake);
}

vec4 applyPosterization(vec4 color)
{
    const float LEVELS = 10;
    float grayscale = max(color.r, max(color.g, color.b));
    float snapped = floor(grayscale * LEVELS) / LEVELS;
    float adjustment = snapped / grayscale;
    return vec4(color.rgb * adjustment, color.a);
}

float getValue(vec2 resolution, vec2 point)
{
    const vec3 luma = vec3(0.299, 0.587, 0.114);
    const float intensity = 0.6;
    return dot(texture(MainSampler, texCoord + vec2(1.0 / resolution.x, 1.0 / resolution.y) * point).xyz, luma) * intensity;
}

vec4 applySobel(vec4 color) {
    vec2 resolution = textureSize(MainSampler, 0);
    const vec4 lineColor = vec4(vec3(33, 26, 29) / 255.0, 1.0);

    // kernel definition (in glsl matrices are filled in column-major order)
    const mat3 Gx = mat3(-1, -2, -1, 0, 0, 0, 1, 2, 1); // x direction kernel
    const mat3 Gy = mat3(-1, 0, 1, -2, 0, 2, -1, 0, 1); // y direction kernel

    // fetch the 3x3 neighbourhood of a fragment

    // first column
    float tx0y0 = getValue(resolution, vec2(-1, -1));
    float tx0y1 = getValue(resolution, vec2(-1, 0));
    float tx0y2 = getValue(resolution, vec2(-1, 1));

    // second column
    float tx1y0 = getValue(resolution, vec2(0, -1));
    float tx1y1 = getValue(resolution, vec2(0, 0));
    float tx1y2 = getValue(resolution, vec2(0, 1));

    // third column
    float tx2y0 = getValue(resolution, vec2(1, -1));
    float tx2y1 = getValue(resolution, vec2(1, 0));
    float tx2y2 = getValue(resolution, vec2(1, 1));

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

    return sobelValue > 0.1 ? lineColor : color;
}

void main()
{
    float time = GameTime * 1200.0;

    float screenShakeIntensity = readChannel(SCREENSHAKE_CHANNEL);
    fragColor = applyScreenShake(texCoord, screenShakeIntensity, time);

    fragColor = applySobel(fragColor);

    fragColor = applyPosterization(fragColor);
}
