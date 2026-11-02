#ifndef SKYS_HORIZON_LIB_COLOR_GLSL
#define SKYS_HORIZON_LIB_COLOR_GLSL

vec4 posterize(vec4 color) {
    const float LEVELS = 10.0;
    float grayscale = max(color.r, max(color.g, color.b));
    float snapped = floor(grayscale * LEVELS) / LEVELS;
    float adjustment = snapped / grayscale;
    return vec4(color.rgb * adjustment, color.a);
}

int decodeRgb24(vec4 color) {
    ivec4 iColor = ivec4(color * 255.0);
    return (iColor.r << 16) + (iColor.g << 8) + iColor.b;
}

#endif
