#ifdef VSH

flat out int isHangarCeilingLight;

const vec3[] hangarCeilingLightCone = vec3[](
        vec3(1.0, 1.0, 1.0),
        vec3(1.0, 1.0, -1.0),
        vec3(1.0, -1.0, 1.0),
        vec3(1.0, -1.0, -1.0),
        vec3(-1.0, 1.0, 1.0),
        vec3(-1.0, 1.0, -1.0),
        vec3(-1.0, -1.0, 1.0),
        vec3(-1.0, -1.0, -1.0)
    );

#endif

#ifdef FSH

flat in int isHangarCeilingLight;

#endif
