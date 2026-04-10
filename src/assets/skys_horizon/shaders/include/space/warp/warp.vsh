#if 0
void main()
#endif
{
    isWarpMarker = 0;

    if (markerColor.a == SPACE_WARP_ALPHA) {
        isWarpMarker = 1;

        isSpaceObject = true;

        // decode information into roll angle and effect opacity
        ivec3 encodedValues = ivec3(round(Color * 255.));
        int iRoll = encodedValues.r << 8 | encodedValues.g;
        float roll = float(iRoll) / 65536.;
        spaceWarpOpacity = float(encodedValues.b) / 255.;
    }
}
