#moj_import <skys_horizon:utility.glsl>

const int SPACE_SKYBOX_ALPHA = 254;
const int SPACE_PLANET_ALPHA = 253;
const int SPACE_WARP_ALPHA = 252;
const int STATIONARY_SKYBOX_ALPHA = 251;

const int SOLID_COLOR_ALPHA = 254;
const int ANIMATED_LOGO_ALPHA = 253;

#ifdef VSH

flat out ivec4 markerColor;

const vec2[] SCREEN_CORNERS = vec2[](
        vec2(-1.0, 1.0),
        vec2(-1.0, -1.0),
        vec2(1.0, -1.0),
        vec2(1.0, 1.0)
    );

#endif

#ifdef FSH

flat in ivec4 markerColor;

#endif

#ifdef SKYS_HORIZON_SPACE_SHADER

#moj_import <skys_horizon:space/space.glsl>

#endif

#ifdef SKYS_HORIZON_SCREEN_SHADER

#moj_import <skys_horizon:screen/screen.glsl>

#endif
