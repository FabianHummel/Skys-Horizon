#version 330

uniform sampler2D MainSampler;
uniform sampler2D DataSampler;

layout(std140) uniform SamplerInfo {
    vec2 OutSize;
    vec2 InSize;
};

#moj_import <minecraft:globals.glsl>

#moj_import <shader_selector:marker_settings.glsl>
#moj_import <shader_selector:utils.glsl>
#moj_import <shader_selector:data_reader.glsl>

in vec2 texCoord;

out vec4 fragColor;

float random(vec2 uv)
{
    return fract(sin(dot(uv, vec2(12.9898,78.233))) * 43758.5453123);
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

void main()
{
    float time = GameTime * 1200.0;

    float screenShakeIntensity = readChannel(SCREENSHAKE_CHANNEL);
    fragColor = applyScreenShake(texCoord, screenShakeIntensity, time);

    ivec2 ds = textureSize(DataSampler, 0);
    // fixed tiny region in texCoord space (top-left)
    if (texCoord.x < 0.1 && texCoord.y < 0.1)
    {
        // map that 0–0.1 area onto the data texture
        vec2 uv = texCoord / 0.1;
        ivec2 xy = ivec2(uv * vec2(ds));
        fragColor = texelFetch(DataSampler, clamp(xy, ivec2(0), ds-1), 0);
        return;
    }
}