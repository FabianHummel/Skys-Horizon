#if 0
void main()
#endif
{
    const float FROM_RADIUS = 0.15;
    const float OUTER_RADIUS = 0.8;
    const float WIDTH = 0.2;
    const float EMPTY_ALPHA = 0.7;

    float t = 1.0 - pow(1.0 - vertexColor.a, 3.0);
    float outerRadius = mix(FROM_RADIUS, OUTER_RADIUS, t);
    float innerRadius = outerRadius - WIDTH;

    float d = length(texCoord0);
    float edge = fwidth(d) * 0.5;

    float outer = 1.0 - smoothstep(outerRadius - edge, outerRadius + edge, d);
    float inner = 1.0 - smoothstep(innerRadius - edge, innerRadius + edge, d);

    float donut = outer - inner;
    float alpha = mix(donut, donut * EMPTY_ALPHA, t);
    fragColor = vec4(1.0, 1.0, 1.0, alpha * TRANSPARENCY);
}
