bool isSpaceObject = false;
mat4 ModelViewMatTmp = ModelViewMat;

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
#moj_import <skys_horizon:space/spaceship/spaceship.vsh>

#if 0
void main()
#endif
{
    if (isSpaceObject == true) {
        // Disable rotation
        ModelViewMatTmp = mat4(1.0);
        ModelViewMatTmp[3] = ModelViewMat[3];
    }
}
