//objmc (HEAVILY STRIPPED)
//https://github.com/Godlander/objmc

isObjmcModel = 0;
ivec2 atlasSize = textureSize(Sampler0, 0);
ivec2 uv = ivec2((UV0 * atlasSize));
vec3 posoffset = vec3(0);
ivec4 t[8];
//read uv offset
t[0] = ivec4(texelFetch(Sampler0, uv, 0) * 255);
ivec2 uvoffset = ivec2(t[0].r*256 + t[0].g, t[0].b*256 + t[0].a);
//find and read topleft pixel
ivec2 topleft = uv - uvoffset;
//if topleft marker is correct
objmcMarker = ivec4(texelFetch(Sampler0, topleft, 0)*255);
if (isObjmcMarker()) {
    bool compression = objmcMarker.a == 79;
    isObjmcModel = 1;
    // header
    //| 2^32   | 2^16x2   | 2^32      | 2^16x2       |
    //| marker | tex size | nvertices | data heights |

    for (int i = 1; i < 8; i++) {
        t[i] = getmeta(topleft, i);
    }
    ivec2 size = ivec2(t[1].r*256 + t[1].g, t[1].b*256 + t[1].a);
    int nvertices = t[2].r*16777216 + t[2].g*65536 + t[2].b*256 + t[2].a;
    // data heights
    int vph = t[5].r*256 + t[5].g;
    int vth = t[5].b*256 + t[5].a;
    //relative vertex id from unique face uv
    int corner = gl_VertexID % 4;
    int id = (((uvoffset.y-1) * size.x) + uvoffset.x) * 4 + corner;
    //calculate height offsets
    int headerheight = 1 + int(ceil(nvertices*0.25/size.x));
    int height = headerheight + size.y;
    //read data
    ivec2 index = getvert(topleft, size.x, height+vph+vth, id, compression);
    posoffset = getpos(topleft, size.x, height, index.x);
    texCoord = getuv(topleft, size.x, height+vph, index.y);

    vec2 onepixel = 1./atlasSize;
    //final uv (pos set manually)
    texCoord = (vec2(topleft.x,topleft.y+headerheight) + texCoord*size)/atlasSize
                //make sure that faces with same uv beginning/ending renders
                + vec2(onepixel.x*0.0001*corner,onepixel.y*0.0001*((corner+1)%4));
}
