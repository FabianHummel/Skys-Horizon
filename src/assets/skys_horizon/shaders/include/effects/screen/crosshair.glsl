#ifndef SKYS_HORIZON_EFFECTS_SCREEN_CROSSHAIR_GLSL
#define SKYS_HORIZON_EFFECTS_SCREEN_CROSSHAIR_GLSL

// effect.y = crosshair variant
const int CROSSHAIR_DEFAULT = 0;
const int CROSSHAIR_TASK = 1;
const int CROSSHAIR_PROGRESS = 2;

#ifdef VSH

void crosshair_vertex(inout TextVertex v) {
    v.uv = SCREEN_CORNERS[gl_VertexIndex % 4];
    v.pos.x -= 0.5;
}

#endif

#ifdef FSH

const float CROSSHAIR_TRANSPARENCY = 0.6;
const float CROSSHAIR_EMPTY_ALPHA = 0.7;
const float CROSSHAIR_FILLED_ALPHA = 0.9;

const float CROSSHAIR_FROM_RADIUS = 0.15;
const float CROSSHAIR_OUTER_RADIUS = 0.8;
const float CROSSHAIR_WIDTH = 0.2;
const float CROSSHAIR_INNER_RADIUS = CROSSHAIR_OUTER_RADIUS - CROSSHAIR_WIDTH;

// rgb of the base color encodes the progress offset in thousandths, biased by 1000
float crosshairProgress(TextFragment f) {
    float percentOffset = (decodeRgb24(f.baseColor) - 1000) / 1000.0;
    return min(f.vertexColor.a + percentOffset, 1.0);
}

vec4 crosshairDefault(TextFragment f) {
    float d = length(f.uv);
    float edge = fwidth(d) * 0.5;
    float circle = 1.0 - smoothstep(CROSSHAIR_FROM_RADIUS - edge, CROSSHAIR_FROM_RADIUS + edge, d);

    return vec4(1.0, 1.0, 1.0, circle * CROSSHAIR_TRANSPARENCY);
}

vec4 crosshairTask(TextFragment f) {
    float radius = crosshairProgress(f);
    float outerRadius = mix(CROSSHAIR_FROM_RADIUS, CROSSHAIR_OUTER_RADIUS, radius);
    float innerRadius = outerRadius - CROSSHAIR_WIDTH;

    float d = length(f.uv);
    float edge = fwidth(d) * 0.5;

    float outer = 1.0 - smoothstep(outerRadius - edge, outerRadius + edge, d);
    float inner = 1.0 - smoothstep(innerRadius - edge, innerRadius + edge, d);
    float donut = outer - inner;

    float alpha = CROSSHAIR_EMPTY_ALPHA * mix(1.0, CROSSHAIR_TRANSPARENCY, radius);

    return vec4(1.0, 1.0, 1.0, donut * alpha);
}

vec4 crosshairProgressRing(TextFragment f) {
    float d = length(f.uv);
    float edge = fwidth(d) * 0.5;

    float outer = 1.0 - smoothstep(CROSSHAIR_OUTER_RADIUS - edge, CROSSHAIR_OUTER_RADIUS + edge, d);
    float inner = 1.0 - smoothstep(CROSSHAIR_INNER_RADIUS - edge, CROSSHAIR_INNER_RADIUS + edge, d);
    float donut = outer - inner;

    float angle = atan(f.uv.x, f.uv.y);
    float t = mod(angle + 2.0 * SH_PI, 2.0 * SH_PI) / (2.0 * SH_PI);
    float arc = step(t, crosshairProgress(f));
    float alpha = mix(CROSSHAIR_EMPTY_ALPHA * CROSSHAIR_TRANSPARENCY, CROSSHAIR_FILLED_ALPHA, arc);

    return vec4(1.0, 1.0, 1.0, donut * alpha);
}

bool crosshair_fragment(TextFragment f, out vec4 color) {
    switch (f.effect.y) {
        case CROSSHAIR_DEFAULT:
        color = crosshairDefault(f);
        return true;

        case CROSSHAIR_TASK:
        color = crosshairTask(f);
        return true;

        case CROSSHAIR_PROGRESS:
        color = crosshairProgressRing(f);
        return true;
    }

    color = vec4(0.0);
    return false;
}

#endif

#endif
