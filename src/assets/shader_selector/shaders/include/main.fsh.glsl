layout(location = 4) flat in int isMarker;
layout(location = 5) flat in ivec4 iColor;

bool ss_fragment(out vec4 color)
{
    if (isMarker == 1) {
        color = vec4(iColor.rgb, 255) / 255.0;
        return true;
    }

    return false;
}
