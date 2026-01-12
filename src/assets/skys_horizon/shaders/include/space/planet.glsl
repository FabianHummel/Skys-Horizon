const int PLANET_ALPHA = 190;

#ifden VSH

bool isPlanetMarker(ivec4 marker) {
    return isCustom == 1 && marker.a == PLANET_ALPHA;
}

#endif

#ifden FSH

#endif