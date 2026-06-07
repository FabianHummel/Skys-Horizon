#if 0
void main()
#endif
{
    if (iColor.rga == POST_MASK_RGA) {
        isMarker = 1;
        int vertex = gl_VertexID % 4;
        int cornerId = FACE_CORNERS[iColor.b * 4 + vertex];
        Pos = boxCorner(cornerId, SKYS_HORIZON_POST_MASK_HANGAR_SKYBOX_MIN, SKYS_HORIZON_POST_MASK_HANGAR_SKYBOX_MAX) - CameraBlockPos + CameraOffset;
    }
}
