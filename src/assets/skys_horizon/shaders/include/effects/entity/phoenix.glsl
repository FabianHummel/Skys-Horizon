#ifndef SKYS_HORIZON_EFFECTS_ENTITY_PHOENIX_GLSL
#define SKYS_HORIZON_EFFECTS_ENTITY_PHOENIX_GLSL

#ifdef VSH

void phoenix_vertex(inout ItemVertex v) {
    v.pos += v.objmcOffset;
}

#endif

#endif
