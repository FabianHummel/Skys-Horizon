vec3 posOffset = vec3(0);
vec3 vertexNormal = Normal;

#if 0
void main()
#endif
{
    isObjmcModel = 0;
    ivec2 uv = ivec2(UV0 * atlasSize);
    ivec4 t[8];

    // find and read topleft pixel
    t[0] = ivec4(texelFetch(Sampler0, uv, 0) * 255);
    ivec2 uvOffset = ivec2(t[0].r * 256 + t[0].g, t[0].b * 256 + t[0].a);
    ivec2 topLeft = uv - uvOffset;

    // if topleft marker is correct
    objmcMarker = get_meta(topLeft, 0);

    if (is_objmc_marker()) {
        isObjmcModel = 1;

        // header
        //  2^32   | 2^(16x2) | 2x2^(16x2)
        //  marker | tex size | data heights
        for (int i = 1; i < 4; i++) {
            t[i] = get_meta(topLeft, i);
        }

        ivec2 texSize = ivec2(t[1].r << 8 + t[1].g, t[1].b << 8 + t[1].a);

        // data heights
        int vph = t[2].r << 8 + t[2].g; // vertex positions
        int vth = t[2].b << 8 + t[2].a; // vertex UVs
        int vnh = t[3].r << 8 + t[3].g; // vertex normals
        int uvh = t[3].b << 8 + t[3].a; // UV offsets (for calculating the topleft)

        //relative vertex id from unique face UV
        int corner = gl_VertexID % 4;
        int id = ((uvOffset.y - 1) * texSize.x + uvOffset.x) * 4 + corner;

        //read data
        int y = 1 + uvh + texSize.y;
        ivec3 index = get_vert(topLeft, texSize.x, y + vph + vth + vnh, id);
        posOffset = get_vec3(topLeft, texSize.x, y, index.x);
        texCoord = get_vec2(topLeft, texSize.x, y + vph, index.y);
        vertexNormal = get_vec3(topLeft, texSize.x, y + vph + vth, index.z);

        vec2 onePixel = 1. / atlasSize;
        //final UV (pos set manually)
        texCoord = (vec2(topLeft.x, topLeft.y + 1 + uvh) + texCoord * texSize) / atlasSize
                //make sure that faces with same UV beginning/ending renders
                + vec2(onePixel.x * 0.0001 * corner, onePixel.y * 0.0001 * ((corner + 1) % 4));
    }
}
