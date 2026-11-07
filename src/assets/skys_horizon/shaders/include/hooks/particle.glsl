#ifndef SKYS_HORIZON_HOOKS_PARTICLE_GLSL
#define SKYS_HORIZON_HOOKS_PARTICLE_GLSL

// Requires shader_selector:marker_settings.glsl for POST_MASK_RGA
#include <skys_horizon:effects/particle/post_mask.glsl>

#ifdef VSH

// Returns true if the particle must be drawn as a shader-selector marker
bool sh_particle_vertex(ivec4 color, inout vec3 pos) {
    if (color.rga == POST_MASK_RGA) {
        post_mask_vertex(color, pos);
        return true;
    }
    return false;
}

#endif

#endif
