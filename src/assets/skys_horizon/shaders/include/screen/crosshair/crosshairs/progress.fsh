#if 0
void main()
#endif
{
    const float OUTER_RADIUS = 0.8;
    const float WIDTH = 0.2;
    const float INNER_RADIUS = OUTER_RADIUS - WIDTH;
    const float PI = 3.1415926535897932;
    const float EMPTY_ALPHA = 0.7;

    float d = length(texCoord0);
    float edge = fwidth(d) * 0.5;

    float outer = 1.0 - smoothstep(OUTER_RADIUS - edge, OUTER_RADIUS + edge, d);
    float inner = 1.0 - smoothstep(INNER_RADIUS - edge, INNER_RADIUS + edge, d);

    float angle = atan(texCoord0.x, texCoord0.y);
    float t = mod(angle + 2.0 * PI, 2.0 * PI) / (2.0 * PI);
    float arc = step(t, vertexColor.a);
    float alpha = mix(EMPTY_ALPHA * TRANSPARENCY, 1.0, arc);

    float donut = outer - inner;
    fragColor = vec4(1.0, 1.0, 1.0, donut * alpha);
}
