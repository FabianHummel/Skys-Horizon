ivec4 markerColor = ivec4(texelFetch(Sampler0, ivec2(0), 0) * 255.0 + 0.5);
ivec4 uvMarkerColor = ivec4(texture(Sampler0, UV0) * 255.0 + 0.5);

#ifdef SKYS_HORIZON_SPACE_SHADER
#moj_import <skys_horizon:space/space.vsh>
#endif

#ifdef SKYS_HORIZON_SCREEN_SHADER
#moj_import <skys_horizon:screen/screen.vsh>
#endif
