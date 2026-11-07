#ifndef SKYS_HORIZON_EFFECTS_SCENE_HANGAR_CEILING_LIGHT_GLSL
#define SKYS_HORIZON_EFFECTS_SCENE_HANGAR_CEILING_LIGHT_GLSL

// Classified only, not implemented yet

#ifdef VSH

const vec3[] hangarCeilingLightCone = vec3[](
        vec3(1.0, 1.0, 1.0),
        vec3(1.0, 1.0, -1.0),
        vec3(1.0, -1.0, 1.0),
        vec3(1.0, -1.0, -1.0),
        vec3(-1.0, 1.0, 1.0),
        vec3(-1.0, 1.0, -1.0),
        vec3(-1.0, -1.0, 1.0),
        vec3(-1.0, -1.0, -1.0)
    );

#endif

#endif
