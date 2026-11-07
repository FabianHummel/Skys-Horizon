#ifndef SKYS_HORIZON_LIB_MATH_GLSL
#define SKYS_HORIZON_LIB_MATH_GLSL

const float SH_PI = 3.1415926535897932;

// Clip-space corners in quad vertex order
const vec2 SCREEN_CORNERS[4] = vec2[](
        vec2(-1.0, 1.0),
        vec2(-1.0, -1.0),
        vec2(1.0, -1.0),
        vec2(1.0, 1.0)
    );

#endif
