#ifndef SKYS_HORIZON_EFFECTS_SCREEN_SOLID_COLOR_GLSL
#define SKYS_HORIZON_EFFECTS_SCREEN_SOLID_COLOR_GLSL

#ifdef VSH

void solid_color_vertex(inout TextVertex v) {
    v.hasClipPos = true;
    v.clipPos = vec4(SCREEN_CORNERS[gl_VertexIndex % 4], 1.0, 1.0);
}

#endif

#ifdef FSH

bool solid_color_fragment(TextFragment f, out vec4 color) {
    color = f.vertexColor * ColorModulator;
    return true;
}

#endif

#endif
