const int SKYBOX_ALPHA = 254;
const int PLANET_ALPHA = 253;
const int WARP_ALPHA = 252;

#ifdef VSH

out float Yaw;
out float Pitch;

vec3 decodeRotation() {
    const float PI = 3.1415926535897932;

    ivec3 encodedRotation = ivec3(round(Color * 255.));
    int iPitch = encodedRotation.r << 4 | encodedRotation.g >> 4;
    float pitch = float(iPitch) * (2.0 * PI / 4095.0);
    int iRoll  = (encodedRotation.g & 0x0F) << 8 | encodedRotation.b;
    float roll  = -float(iRoll) * (2.0 * PI / 4095.0);
    return vec3(pitch, Yaw, roll);
}

#endif

#ifdef FSH

in float Yaw;
in float Pitch;

#endif

#moj_import <skys_horizon:space/planet.glsl>
#moj_import <skys_horizon:space/warp.glsl>
#moj_import <skys_horizon:space/skybox.glsl>
