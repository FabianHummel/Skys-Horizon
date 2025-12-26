#ifndef PI
#define PI 3.1415926535897932
#endif

bool textureAlphaEquals(float valueToExpected) {
    float epsilon = 0.5;
    float colorValue = texture(Sampler0, texCoord).a * 255.0;
    return abs(colorValue - valueToExpected) < epsilon;
}

bool isPlanetMarker(ivec4 marker) {
    return isCustom == 1 && marker.a == 254;
}
