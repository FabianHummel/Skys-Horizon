const int PLANET_ALPHA = 190;

#ifdef VSH

bool isPlanetMarker() {
    return isObjmcModel == 1 && objmcMarker.a == PLANET_ALPHA;
}

#endif
