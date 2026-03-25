#ifdef VSH

flat out int isObjmcModel;
flat out ivec4 objmcMarker;

bool is_objmc_marker() {
    return objmcMarker.rgb == ivec3(12, 34, 56);
}

ivec4 get_meta(ivec2 topLeft, int offset) {
    return ivec4(texelFetch(Sampler0, topLeft + ivec2(offset, 0), 0) * 255);
}

int get_vert_component(ivec2 topLeft, int w, int h, int i) {
    ivec4 v = ivec4(texelFetch(Sampler0, topLeft + ivec2(i % w, h + i / w), 0) * 255);
    return v.r * 65536 + v.g * 256 + v.b;
}

ivec3 get_vert(ivec2 topLeft, int w, int h, int i) {
    return ivec3(
        get_vert_component(topLeft, w, h, i * 3),
        get_vert_component(topLeft, w, h, i * 3 + 1),
        get_vert_component(topLeft, w, h, i * 3 + 2));
}

float get_vec3_component(ivec2 topLeft, int w, int h, int i) {
    vec4 v = texelFetch(Sampler0, topLeft + ivec2(i % w, h + i / w), 0);
    return v.r * 256 + v.g + v.b / 256;
}

vec3 get_vec3(ivec2 topLeft, int w, int h, int i) {
    return vec3(
        get_vec3_component(topLeft, w, h, i * 3),
        get_vec3_component(topLeft, w, h, i * 3 + 1),
        get_vec3_component(topLeft, w, h, i * 3 + 2)) * (255. / 256.) - vec3(128);
}

float get_vec2_component(ivec2 topLeft, int w, int h, int i) {
    vec4 v = texelFetch(Sampler0, topLeft + ivec2(i % w, h + i / w), 0);
    return (v.g * 65280 + v.b * 255) / 65535;
}

vec2 get_vec2(ivec2 topLeft, int w, int h, int i) {
    return vec2(
        get_vec2_component(topLeft, w, h, i * 2),
        get_vec2_component(topLeft, w, h, i * 2 + 1));
}

#endif

#ifdef FSH

flat in int isObjmcModel;
flat in ivec4 objmcMarker;

#endif
