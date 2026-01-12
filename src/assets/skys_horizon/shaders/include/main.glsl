#ifdef VSH

out float Yaw;
out float Pitch;

#endif

#ifden FSH

in float Yaw;
in float Pitch;

#endif

#moj_import <skys_horizon:space/include.glsl>