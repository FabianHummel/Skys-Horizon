#if 0
void main()
#endif
{
    float radius = crosshair_get_progress();
    float outerRadius = mix(FROM_RADIUS, OUTER_RADIUS, radius);
    float innerRadius = outerRadius - WIDTH;

    float d = length(texCoord0);
    float edge = fwidth(d) * 0.5;

    float outer = 1.0 - smoothstep(outerRadius - edge, outerRadius + edge, d);
    float inner = 1.0 - smoothstep(innerRadius - edge, innerRadius + edge, d);
    float donut = outer - inner;

    float alpha = EMPTY_ALPHA * mix(1.0, TRANSPARENCY, radius);

    fragColor = vec4(1.0, 1.0, 1.0, donut * alpha);
}
