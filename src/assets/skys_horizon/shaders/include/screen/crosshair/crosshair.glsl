#ifdef VSH

flat out int crosshairId;

#endif

#ifdef FSH

flat in int crosshairId;

float crosshair_get_progress() {
    float percent_offset = get_int_from_color() / 1000.0;
    return min(percent_offset + vertexColor.a, 1.0);
}

#endif
