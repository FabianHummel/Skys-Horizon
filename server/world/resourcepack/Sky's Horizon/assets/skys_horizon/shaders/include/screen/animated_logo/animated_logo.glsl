#ifdef VSH

flat out int isAnimatedLogoMarker;

#endif

#ifdef FSH

flat in int isAnimatedLogoMarker;

#endif

#ifdef FSH

float getTimeScale() {
    ivec4 markerColor = ivec4(texelFetch(Sampler0, ivec2(1, 0), 0) * 255.0 + 0.5);
    return markerColor.r / 255.0;
}

#endif
