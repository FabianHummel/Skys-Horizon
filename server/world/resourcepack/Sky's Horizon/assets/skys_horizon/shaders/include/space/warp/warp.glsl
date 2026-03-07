bool isWarpMarker() {
    return markerColor.a == WARP_ALPHA;
}

#ifdef VSH

out float spaceWarpOpacity;

#endif

#ifdef FSH

in float spaceWarpOpacity;

#endif
