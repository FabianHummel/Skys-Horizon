#moj_import <skys_horizon:utility.glsl>

const int SPACE_SKYBOX_ALPHA = 254;
const int PLANET_ALPHA = 253;
const int WARP_ALPHA = 252;
const int STATIONARY_SKYBOX_ALPHA = 251;

#ifdef VSH

flat out ivec4 markerColor;

#endif

#ifdef FSH

flat in ivec4 markerColor;

#endif

#moj_import <skys_horizon:space/space.glsl>
