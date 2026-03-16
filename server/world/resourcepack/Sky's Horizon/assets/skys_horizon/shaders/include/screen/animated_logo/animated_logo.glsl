#ifdef VSH

flat out int isAnimatedLogoMarker;

#endif

#ifdef FSH

flat in int isAnimatedLogoMarker;

#endif

#ifdef FSH

float animatedLogoEasing(float x) {
    const float PI = 3.1415926535897932;
    return x < 1.0 ? x < 0.5 ? 4.0 * x * x * x : 1.0 - pow(-2.0 * x + 2.0, 3.0) / 2.0 : 1.0;
}

#endif
