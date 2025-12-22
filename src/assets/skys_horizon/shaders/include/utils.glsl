bool textureAlphaEquals(float valueToExpected) {
    float epsilon = 0.5;
    float colorValue = texture(Sampler0, texCoord).a * 255.0;
    return abs(colorValue - valueToExpected) < epsilon;
}
