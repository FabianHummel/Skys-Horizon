#ifndef SKYS_HORIZON_HOOKS_WORLD_GLSL
#define SKYS_HORIZON_HOOKS_WORLD_GLSL

#include <skys_horizon:lib/color.glsl>

// Applied to all vanilla-shaded world geometry (terrain, blocks, items)
vec4 sh_world_shade(vec4 color) {
    return posterize(color);
}

#endif
