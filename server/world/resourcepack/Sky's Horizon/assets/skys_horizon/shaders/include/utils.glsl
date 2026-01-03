#ifndef PI
#define PI 3.1415926535897932
#endif

#moj_import <skys_horizon:space/skybox.glsl>
#moj_import <skys_horizon:space/planet.glsl>

int getTextureAlpha() {
    return int(texture(Sampler0, texCoord).a * 255);
}
