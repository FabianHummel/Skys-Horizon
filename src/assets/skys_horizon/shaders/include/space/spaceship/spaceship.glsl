#ifdef VSH

flat out int isSpaceship;

const mat3 SPACESHIP_MAT = mat3(
        1.0, 0.0, 0.0,
        0.0, 1.0, 0.0,
        0.0, 0.0, 2.0);

#endif

#ifdef FSH

flat in int isSpaceship;

#endif
