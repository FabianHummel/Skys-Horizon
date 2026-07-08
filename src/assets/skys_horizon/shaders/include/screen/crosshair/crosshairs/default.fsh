#if 0
void main()
#endif
{
    float d = length(texCoord0);
    float edge = fwidth(d) * 0.5;
    float circle = 1.0 - smoothstep(FROM_RADIUS - edge, FROM_RADIUS + edge, d);

    fragColor = vec4(1.0, 1.0, 1.0, circle * TRANSPARENCY);
}
