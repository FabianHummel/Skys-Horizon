vec2[] corners = vec2[](
        vec2(0.0, 1.0),
        vec2(0.0, 0.0),
        vec2(1.0, 0.0),
        vec2(1.0, 1.0)
    );

float decodeColor(vec4 color) {
    uvec4 iColor = uvec4(round(color * 255.));
    uint iValue = iColor.r << 24 | iColor.g << 16 | iColor.b << 8 | iColor.a;
    return uintBitsToFloat(iValue);
}

vec4 encodeFloat(float value) {
    uint iValue = floatBitsToUint(value);
    return vec4(
        iValue >> 24u,
        iValue >> 16u & 0xffu,
        iValue >>  8u & 0xffu,
        iValue        & 0xffu
    ) / 255.;
}
