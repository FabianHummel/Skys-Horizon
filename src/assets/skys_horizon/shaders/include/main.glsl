#ifdef VSH

out float Yaw;
out float Pitch;
out ivec4 textureColor;

#endif

#ifdef FSH

in float Yaw;
in float Pitch;
in ivec4 textureColor;

#endif

#moj_import <skys_horizon:space/planet.glsl>
#moj_import <skys_horizon:space/skybox.glsl>