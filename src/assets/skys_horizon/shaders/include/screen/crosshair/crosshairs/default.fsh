#if 0
void main()
#endif
{
    const float RADIUS = 0.15;
    const float PI = 3.1415926535897932;

    float d = length(texCoord0);
    float edge = fwidth(d) * 0.5;
    float circle = 1.0 - smoothstep(RADIUS - edge, RADIUS + edge, d);

    fragColor = vec4(1.0, 1.0, 1.0, circle * TRANSPARENCY);
}
