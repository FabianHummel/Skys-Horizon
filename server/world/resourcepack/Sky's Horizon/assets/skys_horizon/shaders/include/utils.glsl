#ifndef PI
#define PI 3.1415926535897932
#endif

#moj_import <skys_horizon:space/skybox.glsl>
#moj_import <skys_horizon:space/planet.glsl>

int getTextureAlpha() {
    float alpha = texture(Sampler0, texCoord).a * 255.0;
    return int(round(alpha));
}

bool isPlanetMarker(ivec4 marker) {
    return isCustom == 1 && marker.a == PLANET_ALPHA;
}
