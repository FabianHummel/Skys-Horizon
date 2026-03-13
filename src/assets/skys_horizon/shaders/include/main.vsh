#if 0
void main()
#endif
{
    #ifndef SKYS_HORIZON_SCREEN_SHADER

    markerColor = ivec4(texture(Sampler0, UV0) * 255.0 + 0.5);

    #else

    markerColor = ivec4(texelFetch(Sampler0, ivec2(0, 0), 0) * 255.0 + 0.5);

    #endif
}

#ifdef SKYS_HORIZON_SPACE_SHADER

#moj_import <skys_horizon:space/space.vsh>

#endif

#ifdef SKYS_HORIZON_SCREEN_SHADER

#moj_import <skys_horizon:screen/screen.vsh>

#endif
