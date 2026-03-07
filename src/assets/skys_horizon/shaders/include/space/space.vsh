#if 0
void main()
#endif
{
    Yaw = -atan(Normal.x, Normal.z);
    Pitch = -atan(Normal.y, length(Normal.xz));
}

#moj_import <skys_horizon:space/planet/planet.vsh>
#moj_import <skys_horizon:space/warp/warp.vsh>
#moj_import <skys_horizon:space/skybox/skybox.vsh>
