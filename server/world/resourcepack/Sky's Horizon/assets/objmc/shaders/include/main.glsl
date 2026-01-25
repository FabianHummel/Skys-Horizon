//3d rotation matrix from Barf Creations
mat3 rotate(vec3 angles) {
    float sx = sin(angles.x);
    float cx = cos(angles.x);
    float sy = sin(-angles.y);
    float cy = cos(-angles.y);
    float sz = sin(-angles.z);
    float cz = cos(-angles.z);
    return mat3(
        -sx*sy*sz+cy*cz, -cx*sz, -sx*cy*sz-sy*cz,
        sx*sy*cz+cy*sz, cx*cz, -sy*sz+sx*cy*cz,
        cx*sy, -sx, cx*cy
    );
}

#ifdef VSH

flat out int isObjmcModel;
flat out ivec4 objmcMarker;

bool isObjmcMarker() {
    return objmcMarker.rgb == ivec3(12,34,56);
}

ivec4 getmeta(ivec2 topleft, int offset) {
    return ivec4(texelFetch(Sampler0, topleft + ivec2(offset,0), 0) * 255);
}

vec3 getpos(ivec2 topleft, int w, int h, int index) {
    int i = index*3;
    vec4 x = texelFetch(Sampler0, topleft + ivec2((i  )%w,h+((i  )/w)), 0);
    vec4 y = texelFetch(Sampler0, topleft + ivec2((i+1)%w,h+((i+1)/w)), 0);
    vec4 z = texelFetch(Sampler0, topleft + ivec2((i+2)%w,h+((i+2)/w)), 0);
    return vec3(
        (x.r*256)+(x.g)+(x.b/256),
        (y.r*256)+(y.g)+(y.b/256),
        (z.r*256)+(z.g)+(z.b/256)
    )*(255./256.) - vec3(128);
}

vec2 getuv(ivec2 topleft, int w, int h, int index) {
    int i = index*2;
    vec4 x = texelFetch(Sampler0, topleft + ivec2((i  )%w,h+((i  )/w)), 0);
    vec4 y = texelFetch(Sampler0, topleft + ivec2((i+1)%w,h+((i+1)/w)), 0);
    return vec2(
        ((x.g*65280)+(x.b*255))/65535,
        ((y.g*65280)+(y.b*255))/65535
    );
}

ivec2 getvert(ivec2 topleft, int w, int h, int index, bool compressionEnabled) {

    if(!compressionEnabled) {
        int i = index*2;
        ivec4 a = ivec4(texelFetch(Sampler0, topleft + ivec2((i  )%w,h+((i  )/w)), 0)*255);
        ivec4 b = ivec4(texelFetch(Sampler0, topleft + ivec2((i+1)%w,h+((i+1)/w)), 0)*255);
        return ivec2(
            ((a.r*65536)+(a.g*256)+a.b),
            ((b.r*65536)+(b.g*256)+b.b)
        );
    } else {
        ivec4 a = ivec4(texelFetch(Sampler0, topleft + ivec2((index  )%w,h+((index  )/w)), 0)*255);
        return ivec2(
            ((a.r*65536)+(a.g*256)+a.b),
            a.a - 1
        );
    }
}

#endif

#ifdef FSH

flat in int isObjmcModel;
flat in ivec4 objmcMarker;

#endif
