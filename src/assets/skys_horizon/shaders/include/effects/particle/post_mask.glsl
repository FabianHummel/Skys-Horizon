#ifndef SKYS_HORIZON_EFFECTS_PARTICLE_POST_MASK_GLSL
#define SKYS_HORIZON_EFFECTS_PARTICLE_POST_MASK_GLSL

// Particles colored POST_MASK_RGA are expanded into a box (b = face index) that masks the post effects

#ifdef VSH

const vec3 SKYS_HORIZON_POST_MASK_HANGAR_SKYBOX_MIN = vec3(71.0, 1.0, -21.0);
const vec3 SKYS_HORIZON_POST_MASK_HANGAR_SKYBOX_MAX = vec3(89.0, 10.0, -3.0);

const int FACE_CORNERS[24] = int[](
        0, 2, 6, 4, // front
        5, 7, 3, 1, // back
        1, 3, 2, 0, // left
        4, 6, 7, 5, // right
        3, 7, 6, 2, // top
        4, 5, 1, 0 // bottom
    );

vec3 boxCorner(int i, vec3 boxMin, vec3 boxMax) {
    return vec3(
        (i & 1) != 0 ? boxMax.x : boxMin.x,
        (i & 2) != 0 ? boxMax.y : boxMin.y,
        (i & 4) != 0 ? boxMax.z : boxMin.z
    );
}

void post_mask_vertex(ivec4 color, inout vec3 pos) {
    int cornerId = FACE_CORNERS[color.b * 4 + gl_VertexIndex % 4];
    vec3 corner = boxCorner(cornerId, SKYS_HORIZON_POST_MASK_HANGAR_SKYBOX_MIN, SKYS_HORIZON_POST_MASK_HANGAR_SKYBOX_MAX);
    pos = corner - vec3(CameraBlockPos) + CameraOffset;
}

#endif

#endif
