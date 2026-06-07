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

vec3 boxCorner(int i, vec3 min, vec3 max) {
    return vec3(
        (i & 1) != 0 ? max.x : min.x,
        (i & 2) != 0 ? max.y : min.y,
        (i & 4) != 0 ? max.z : min.z
    );
}

#endif
