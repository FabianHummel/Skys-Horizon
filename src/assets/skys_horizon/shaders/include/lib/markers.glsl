#ifndef SKYS_HORIZON_LIB_MARKERS_GLSL
#define SKYS_HORIZON_LIB_MARKERS_GLSL

// Effect IDs (shEffect.x), unique across all hosts; 0 = vanilla rendering
const int SH_EFFECT_NONE = 0;
const int SH_EFFECT_PLANET = 1;
const int SH_EFFECT_WARP = 2;
const int SH_EFFECT_SKYBOX = 3;
const int SH_EFFECT_SPACESHIP = 4;
const int SH_EFFECT_PHOENIX = 5;
const int SH_EFFECT_HANGAR_CEILING_LIGHT = 6;
const int SH_EFFECT_ANIMATED_LOGO = 7;
const int SH_EFFECT_SOLID_COLOR = 8;
const int SH_EFFECT_CROSSHAIR = 9;

// Item markers: alpha of the texel under UV0, or of the objmc marker for objmc models
const int SPACE_SKYBOX_ALPHA = 254;
const int SPACE_WARP_ALPHA = 252;
const int STATIONARY_SKYBOX_ALPHA = 251;
const ivec2 SPACE_PLANET_ALPHAS = ivec2(250, 240);
const int SPACESHIP_ALPHA = 239;
const int PHOENIX_ALPHA = 238;
const int HANGAR_CEILING_LIGHT_ALPHA = 237;

// Text markers: rgb is always SCREEN_MARKER_RGB
const ivec3 SCREEN_MARKER_RGB = ivec3(12, 34, 56);
const int SOLID_COLOR_ALPHA = 254;
const int ANIMATED_LOGO_ALPHA = 253;
const ivec2 CROSSHAIR_ALPHAS = ivec2(252, 200);

#endif
