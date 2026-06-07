ivec4 markerColor = ivec4(texture(Sampler0, UV0) * 255.0 + 0.5);

#ifdef SKYS_HORIZON_SPACE_SHADER
#moj_import <skys_horizon:space/space.vsh>
#endif

#ifdef SKYS_HORIZON_SCREEN_SHADER
#moj_import <skys_horizon:screen/screen.vsh>
#endif

#ifdef SKYS_HORIZON_ENTITY_SHADER
#moj_import <skys_horizon:entity/entity.vsh>
#endif

#ifdef SKYS_HORIZON_SCENE_SHADER
#moj_import <skys_horizon:scene/scene.vsh>
#endif

#ifdef SKYS_HORIZON_PARTICLE_SHADER
#moj_import <skys_horizon:post/mask.vsh>
#endif
