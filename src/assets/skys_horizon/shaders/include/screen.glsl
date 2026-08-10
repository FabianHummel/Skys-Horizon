vec4 applyPosterization(vec4 color)
{
    const float LEVELS = 10;
    float grayscale = max(color.r, max(color.g, color.b));
    float snapped = floor(grayscale * LEVELS) / LEVELS;
    float adjustment = snapped / grayscale;
    return vec4(color.rgb * adjustment, color.a);
}
