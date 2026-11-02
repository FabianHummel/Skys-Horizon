bool isSpaceObject = false;
mat4 ModelViewMatTmp = ModelViewMat;

#if 0
void main()
#endif
{
    Yaw = -atan(Normal.x, Normal.z);
    Pitch = -atan(Normal.y, length(Normal.xz));
}

#include <skys_horizon:space/planet/planet.vsh.glsl>
#include <skys_horizon:space/warp/warp.vsh.glsl>
#include <skys_horizon:space/skybox/skybox.vsh.glsl>
#include <skys_horizon:space/spaceship/spaceship.vsh.glsl>

#if 0
void main()
#endif
{
    if (isSpaceObject == true) {
        // Disable rotation
        ModelViewMatTmp = mat4(1.0);
        ModelViewMatTmp[3] = ModelViewMat[3];
    }

    #define ModelViewMat ModelViewMatTmp
}
