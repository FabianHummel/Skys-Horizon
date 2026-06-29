#if 0
void main()
#endif
{
    const float FROM_RADIUS = 0.15;
    const float OUTER_RADIUS = 0.8;
    const float WIDTH = 0.2;
    const float EMPTY_ALPHA = 0.7;
    const float FILLED_ALPHA = 0.9;
    const float PI = 3.1415926535897932;

    float radius = min(vertexColor.a + float(iBaseColor.r) / 255.0, 1.0);
    float outerRadius = mix(FROM_RADIUS, OUTER_RADIUS, radius);
    float innerRadius = outerRadius - WIDTH;

    float d = length(texCoord0);
    float edge = fwidth(d) * 0.5;

    float outer = 1.0 - smoothstep(outerRadius - edge, outerRadius + edge, d);
    float inner = 1.0 - smoothstep(innerRadius - edge, innerRadius + edge, d);

    float angle = atan(texCoord0.x, texCoord0.y);
    float t = mod(angle + 2.0 * PI, 2.0 * PI) / (2.0 * PI);
    float progress = float(iBaseColor.g << 8 | iBaseColor.b) / 65535.0;
    float arc = step(t, progress * radius);
    float alpha = mix(EMPTY_ALPHA * mix(1.0, TRANSPARENCY, radius), FILLED_ALPHA, arc);

    float donut = outer - inner;
    fragColor = vec4(1.0, 1.0, 1.0, donut * alpha);
}
