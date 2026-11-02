#ifdef VSH

layout(location = 16) flat out int isWarpMarker;
layout(location = 17) out float spaceWarpOpacity;

#endif

#ifdef FSH

layout(location = 16) flat in int isWarpMarker;
layout(location = 17) in float spaceWarpOpacity;

#endif
