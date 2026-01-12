int alpha = getTextureAlpha();
Yaw = -atan(Normal.x, Normal.z);
Pitch = -atan(Normal.y, length(Normal.xz));

#moj_import <skys_horizon:space/planet.vsh>
#moj_import <skys_horizon:space/skybox.vsh>