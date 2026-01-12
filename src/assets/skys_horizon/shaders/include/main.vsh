Yaw = -atan(Normal.x, Normal.z);
Pitch = -atan(Normal.y, length(Normal.xz));
textureColor = ivec4(round(texture(Sampler0, UV0) * 255.0));

#moj_import <skys_horizon:space/planet.vsh>
#moj_import <skys_horizon:space/skybox.vsh>