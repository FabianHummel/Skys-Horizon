//3d rotation matrix from Barf Creations
mat3 rotate(vec3 angles) {
    float sx = sin(angles.x);
    float cx = cos(angles.x);
    float sy = sin(-angles.y);
    float cy = cos(-angles.y);
    float sz = sin(-angles.z);
    float cz = cos(-angles.z);
    return mat3(
        -sx * sy * sz + cy * cz, -cx * sz, -sx * cy * sz - sy * cz,
        sx * sy * cz + cy * sz, cx * cz, -sy * sz + sx * cy * cz,
        cx * sy, -sx, cx * cy
    );
}
