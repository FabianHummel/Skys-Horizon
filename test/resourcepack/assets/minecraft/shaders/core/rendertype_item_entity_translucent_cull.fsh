#version 150

#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:globals.glsl>
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:projection.glsl>

uniform sampler2D Sampler0;

in float sphericalVertexDistance;
in float cylindricalVertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;
in vec2 texCoord1;
in vec3 vertexPosition;
in vec4 baseColor;

out vec4 fragColor;

const float speed = 1000.0;
const float density = 500.0;
const float compression = 0.3;
const float trailSize = 20.0;
const float brightness = 5.0;
const float centerSize = 1.0;
const float centerEdge = 0.6;
const float PI = 3.14159265359;

bool textureAlphaEquals(float valueToExpected) {
    float epsilon = 1.0;
    float colorValue = texture(Sampler0, texCoord0).a * 255.0;
    return abs(colorValue - valueToExpected) < epsilon;
}

vec3 getSpaceWarp(vec3 dir, float intensity) {
    // Make radial coordinates
    float dist = length(dir.xy);
    float mask = smoothstep(centerSize - centerEdge, centerSize, dist);
    float angle = atan(dir.y, dir.x);
    vec2 uv;
    uv.x = angle / PI * density;
    uv.y = dir.z / dist;

    // Apply warp effect (raindrops)
    float time = GameTime * speed * intensity;

    vec2 duv = vec2(floor(uv.x), uv.y) * compression;
    float offset = sin(duv.x);
    float fall = cos(duv.x * 30.0);
    float trail = mix(100.0, trailSize, fall);

    float drop = fract(duv.y + time * fall + offset) * trail;
    drop = 1.0 / drop;
    drop = smoothstep(0.0, 1.0, drop * drop);
    drop = sin(drop * PI) * fall * brightness;

    float shape = sin(fract(uv.x) * PI);
    drop *= shape * shape;

    return vec3(1.0) * drop * mask;
}

mat3 getDynamicRotationMatrix(vec3 angles) {
    float cY = cos(angles.x);
    float sY = sin(angles.x);
    float cP = cos(angles.y);
    float sP = sin(angles.y);
    float cR = cos(angles.z);
    float sR = sin(angles.z);

    // 2. Return the mat3, using column-major order (Column 0, Column 1, Column 2)
    // The coefficients below are the result of the matrix product Rz(roll) * Rx(pitch) * Ry(yaw)
    return mat3(
        // === Column 0 (x-axis base vector) ===
        cR * cY + sR * sP * sY,   // m00
        -sR * cY + cR * sP * sY,  // m10
        -cP * sY,                 // m20

        // === Column 1 (y-axis base vector) ===
        sR * cP,                  // m01
        cR * cP,                  // m11
        sP,                       // m21

        // === Column 2 (z-axis base vector) ===
        cR * sY - sR * sP * cY,   // m02
        -sR * sY - cR * sP * cY,  // m12
        cP * cY                   // m22
    );
}

void main() {
    vec4 color = texture(Sampler0, texCoord0) * vertexColor * ColorModulator;

    if (textureAlphaEquals(254)) {
        vec3 angles = vec3(baseColor.g * PI * 2.0, baseColor.b * PI - PI / 2.0, 0.0);
        mat3 rotation = getDynamicRotationMatrix(angles);
        vec3 viewDir = rotation * normalize(vertexPosition);
        vec3 final = getSpaceWarp(viewDir, baseColor.r);
        fragColor = vec4(final, 1.0);
        return;
    }

    if (color.a < 0.1) {
        discard;
    }

    fragColor = apply_fog(color, sphericalVertexDistance, cylindricalVertexDistance, FogEnvironmentalStart, FogEnvironmentalEnd, FogRenderDistanceStart, FogRenderDistanceEnd, FogColor);
}