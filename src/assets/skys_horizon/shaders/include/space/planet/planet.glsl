#ifdef VSH

flat out int planetId;

const vec3 SORAX4B_POSITION = vec3(0.0, 20.0, 0.0);

const vec3[] PLANET_POSITIONS = vec3[](
        SUN_POSITION,
        SORAX4B_POSITION
    );

#endif

#ifdef FSH

flat in int planetId;

#endif
