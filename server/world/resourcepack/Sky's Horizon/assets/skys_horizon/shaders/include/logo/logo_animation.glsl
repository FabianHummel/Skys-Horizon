bool isLogoAnimationMarker() {
    ivec4 marker = ivec4(texelFetch(Sampler0, ivec2(0, 0), 0) * 255.0 + 0.5);
    return marker.rgb == ivec3(12, 34, 56);
}

float getTimeScale() {
    ivec4 marker = ivec4(texelFetch(Sampler0, ivec2(1, 0), 0) * 255.0 + 0.5);
    return marker.r / 255.0;
}
