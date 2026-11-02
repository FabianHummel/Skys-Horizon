ivec4 markerColor = ivec4(texture(Sampler0, UV0) * 255.0 + 0.5);

#ifdef SKYS_HORIZON_SPACE_SHADER
#include <skys_horizon:space/space.vsh.glsl>
#endif

#ifdef SKYS_HORIZON_SCREEN_SHADER
#include <skys_horizon:screen/screen.vsh.glsl>
#endif

#ifdef SKYS_HORIZON_ENTITY_SHADER
#include <skys_horizon:entity/entity.vsh.glsl>
#endif

#ifdef SKYS_HORIZON_SCENE_SHADER
#include <skys_horizon:scene/scene.vsh.glsl>
#endif

#ifdef SKYS_HORIZON_PARTICLE_SHADER
#include <skys_horizon:post/mask.vsh.glsl>
#endif
