#ifdef VSH

layout(location = 19) flat out int isSpaceship;

const mat3 SPACESHIP_MAT = mat3(
        -1.0, 0.0, 0.0,
        0.0, 1.0, 0.0,
        0.0, 0.0, -2.0);

#endif

#ifdef FSH

layout(location = 19) flat in int isSpaceship;

#endif
