const int SPACE_SKYBOX_ALPHA = 254;
const int SPACE_WARP_ALPHA = 252;
const int STATIONARY_SKYBOX_ALPHA = 251;
const ivec2 SPACE_PLANET_ALPHAS = ivec2(250, 240);
const int SPACESHIP_ALPHA = 239;
const int PHOENIX_ALPHA = 238;
const int HANGAR_CEILING_LIGHT_ALPHA = 237;

const int SOLID_COLOR_ALPHA = 254;
const int ANIMATED_LOGO_ALPHA = 253;
const ivec2 CROSSHAIR_ALPHAS = ivec2(252, 200);

int get_int_from_color() {
    ivec4 iBaseColor = ivec4(baseColor * 255);
    return (iBaseColor.r << 16) + (iBaseColor.g << 8) + iBaseColor.b;
}

#ifdef VSH

const vec2[] SCREEN_CORNERS = vec2[](
        vec2(-1.0, 1.0),
        vec2(-1.0, -1.0),
        vec2(1.0, -1.0),
        vec2(1.0, 1.0)
    );

#endif

#ifdef SKYS_HORIZON_SPACE_SHADER
#moj_import <skys_horizon:space/space.glsl>
#endif

#ifdef SKYS_HORIZON_SCREEN_SHADER
#moj_import <skys_horizon:screen/screen.glsl>
#endif

#ifdef SKYS_HORIZON_ENTITY_SHADER
#moj_import <skys_horizon:entity/entity.glsl>
#endif

#ifdef SKYS_HORIZON_SCENE_SHADER
#moj_import <skys_horizon:scene/scene.glsl>
#endif
