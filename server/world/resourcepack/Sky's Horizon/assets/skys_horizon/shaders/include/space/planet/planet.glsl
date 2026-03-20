#ifdef VSH

flat out int planetMarker;

const vec3 SORAX4B_POSITION = vec3(100.0, 0.0, 0.0);

const vec3[] PLANET_POSITIONS = vec3[](SORAX4B_POSITION);

#endif

#ifdef FSH

flat in int planetMarker;

#endif
