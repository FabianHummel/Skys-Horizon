ivec4 markerColor2 = ivec4(texelFetch(Sampler0, ivec2(0, 0), 0) * 255.0 + 0.5);

#include <skys_horizon:screen/animated_logo/animated_logo.vsh.glsl>
#include <skys_horizon:screen/solid_color/solid_color.vsh.glsl>
#include <skys_horizon:screen/crosshair/crosshair.vsh.glsl>
