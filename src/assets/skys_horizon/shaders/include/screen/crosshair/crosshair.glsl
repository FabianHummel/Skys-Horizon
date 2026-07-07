#ifdef VSH

flat out int crosshairId;

#endif

#ifdef FSH

flat in int crosshairId;

float crosshair_get_progress() {
    float percentOffset = (get_int_from_color() - 1000) / 1000.0;
    return min(vertexColor.a + percentOffset, 1.0);
}

#endif
