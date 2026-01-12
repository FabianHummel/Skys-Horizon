const int PLANET_ALPHA = 190;

#ifdef VSH

bool isPlanetMarker() {
    return isObjmcModel == 1 && marker.a == PLANET_ALPHA;
}

#endif

#ifdef FSH

#endif