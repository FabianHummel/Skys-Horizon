#ifndef SKYS_HORIZON_HOOKS_ITEM_GLSL
#define SKYS_HORIZON_HOOKS_ITEM_GLSL

#include <skys_horizon:lib/interface.glsl>
#include <skys_horizon:lib/markers.glsl>
#include <skys_horizon:lib/math.glsl>
#include <skys_horizon:lib/quaternion.glsl>
#include <skys_horizon:lib/noise.glsl>

// Locations: vanilla 0-6, host 7-9 (Pos, atlasSize, baseColor), Sky's Horizon 10-12, objmc 16+
SH_FLAT_VARYING(10, ivec4, shEffect)
SH_FLAT_VARYING(11, vec4, shPayload0)
SH_FLAT_VARYING(12, vec4, shPayload1)

#ifdef VSH

struct ItemVertex {
    ivec4 marker;       // texel under UV0
    vec3 data;          // vertex color, used as encoded data
    float yaw;
    vec2 uv;
    bool isObjmc;
    ivec4 objmcMarker;
    vec3 objmcOffset;

    vec3 pos;
    vec3 normal;
    mat4 modelView;

    bool hasClipPos;    // clipPos replaces the projected position
    vec4 clipPos;
    ivec4 effect;       // x = effect id, yzw = effect specific
    vec4 payload0;
    vec4 payload1;
};

#endif

#ifdef FSH

struct ItemFragment {
    vec4 color;         // sampled texture
    vec3 pos;
    vec3 normal;
    vec2 uv;
    vec2 atlasSize;
    ivec4 effect;
    vec4 payload0;
    vec4 payload1;
};

#endif

#include <skys_horizon:effects/space/common.glsl>
#include <skys_horizon:effects/space/planet.glsl>
#include <skys_horizon:effects/space/warp.glsl>
#include <skys_horizon:effects/space/skybox.glsl>
#include <skys_horizon:effects/space/spaceship.glsl>
#include <skys_horizon:effects/entity/phoenix.glsl>
#include <skys_horizon:effects/scene/hangar_ceiling_light.glsl>

#ifdef VSH

// Order defines priority
ivec2 sh_item_classify(ItemVertex v) {
    if (v.isObjmc && v.objmcMarker.a <= SPACE_PLANET_ALPHAS.x && v.objmcMarker.a >= SPACE_PLANET_ALPHAS.y) {
        return ivec2(SH_EFFECT_PLANET, 0);
    }
    if (v.marker.a == SPACE_WARP_ALPHA) {
        return ivec2(SH_EFFECT_WARP, 0);
    }
    if (v.marker.a == STATIONARY_SKYBOX_ALPHA) {
        return ivec2(SH_EFFECT_SKYBOX, SKYBOX_STATIONARY);
    }
    if (v.marker.a == SPACE_SKYBOX_ALPHA) {
        return ivec2(SH_EFFECT_SKYBOX, SKYBOX_SPACE);
    }
    if (v.marker.a == SPACESHIP_ALPHA && v.data != vec3(0.0)) {
        return ivec2(SH_EFFECT_SPACESHIP, 0);
    }
    if (v.isObjmc && v.objmcMarker.a == PHOENIX_ALPHA) {
        return ivec2(SH_EFFECT_PHOENIX, 0);
    }
    if (v.marker.a == HANGAR_CEILING_LIGHT_ALPHA) {
        return ivec2(SH_EFFECT_HANGAR_CEILING_LIGHT, 0);
    }
    return ivec2(SH_EFFECT_NONE, 0);
}

ItemVertex sh_item_vertex(vec3 pos, vec3 normal, bool isObjmc, ivec4 objmcMarker, vec3 objmcOffset) {
    ItemVertex v;
    v.marker = ivec4(texture(Sampler0, UV0) * 255.0 + 0.5);
    v.data = Color.rgb;
    v.yaw = -atan(Normal.x, Normal.z);
    v.uv = UV0;
    v.isObjmc = isObjmc;
    v.objmcMarker = objmcMarker;
    v.objmcOffset = objmcOffset;
    v.pos = pos;
    v.normal = normal;
    v.modelView = ModelViewMat;
    v.hasClipPos = false;
    v.clipPos = vec4(0.0);
    v.effect = ivec4(sh_item_classify(v), 0, 0);
    v.payload0 = vec4(0.0);
    v.payload1 = vec4(0.0);

    switch (v.effect.x) {
        case SH_EFFECT_PLANET:
        planet_vertex(v);
        break;

        case SH_EFFECT_WARP:
        warp_vertex(v);
        break;

        case SH_EFFECT_SKYBOX:
        skybox_vertex(v);
        break;

        case SH_EFFECT_SPACESHIP:
        spaceship_vertex(v);
        break;

        case SH_EFFECT_PHOENIX:
        phoenix_vertex(v);
        break;

        default:
        // objmc models without a dedicated effect are only offset
        if (v.isObjmc) {
            v.pos += v.objmcOffset;
        }
        break;
    }

    shEffect = v.effect;
    shPayload0 = v.payload0;
    shPayload1 = v.payload1;
    return v;
}

#endif

#ifdef FSH

// Returns true if an effect fully shaded the fragment, vanilla shading is skipped then
bool sh_item_fragment(vec4 color, vec3 pos, vec3 normal, vec2 uv, vec2 atlasSize, out vec4 result) {
    ItemFragment f = ItemFragment(color, pos, normal, uv, atlasSize, shEffect, shPayload0, shPayload1);

    switch (f.effect.x) {
        case SH_EFFECT_PLANET:
        return planet_fragment(f, result);

        case SH_EFFECT_WARP:
        return warp_fragment(f, result);

        case SH_EFFECT_SKYBOX:
        return skybox_fragment(f, result);

        case SH_EFFECT_SPACESHIP:
        return spaceship_fragment(f, result);
    }

    result = vec4(0.0);
    return false;
}

#endif

#endif
