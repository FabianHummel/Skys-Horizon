#if 0
void main()
#endif
{
    float d = length(texCoord0);
    float edge = fwidth(d) * 0.5;

    float outer = 1.0 - smoothstep(OUTER_RADIUS - edge, OUTER_RADIUS + edge, d);
    float inner = 1.0 - smoothstep(INNER_RADIUS - edge, INNER_RADIUS + edge, d);
    float donut = outer - inner;

    float angle = atan(texCoord0.x, texCoord0.y);
    float t = mod(angle, 2.0 * PI) / (2.0 * PI);
    float progress = crosshair_get_progress();
    float arc = step(t, progress);
    float alpha = mix(EMPTY_ALPHA * TRANSPARENCY, FILLED_ALPHA, arc);

    fragColor = vec4(1.0, 1.0, 1.0, donut * alpha);
}
