#ifndef SKYS_HORIZON_HOOKS_TEXT_GLSL
#define SKYS_HORIZON_HOOKS_TEXT_GLSL

#include <skys_horizon:lib/interface.glsl>
#include <skys_horizon:lib/markers.glsl>
#include <skys_horizon:lib/math.glsl>
#include <skys_horizon:lib/color.glsl>

// Locations: vanilla 0-3, host 4 (baseColor), Sky's Horizon 5
SH_FLAT_VARYING(5, ivec4, shEffect)

#ifdef VSH

struct TextVertex {
    ivec4 marker;       // texel under UV0
    ivec4 atlasMarker;  // first texel of the bound texture
    vec3 pos;
    vec2 uv;

    bool hasClipPos;    // clipPos replaces the projected position
    vec4 clipPos;
    ivec4 effect;       // x = effect id, yzw = effect specific
};

#endif

#ifdef FSH

struct TextFragment {
    vec4 vertexColor;
    vec4 baseColor;
    vec2 uv;
    ivec4 effect;
};

#endif

#include <skys_horizon:effects/screen/animated_logo.glsl>
#include <skys_horizon:effects/screen/solid_color.glsl>
#include <skys_horizon:effects/screen/crosshair.glsl>

#ifdef VSH

// Order defines priority
ivec2 sh_text_classify(TextVertex v) {
    if (v.atlasMarker == ivec4(SCREEN_MARKER_RGB, ANIMATED_LOGO_ALPHA)) {
        return ivec2(SH_EFFECT_ANIMATED_LOGO, 0);
    }
    if (v.marker == ivec4(SCREEN_MARKER_RGB, SOLID_COLOR_ALPHA)) {
        return ivec2(SH_EFFECT_SOLID_COLOR, 0);
    }
    if (v.marker.rgb == SCREEN_MARKER_RGB && v.marker.a <= CROSSHAIR_ALPHAS.x && v.marker.a >= CROSSHAIR_ALPHAS.y) {
        return ivec2(SH_EFFECT_CROSSHAIR, CROSSHAIR_ALPHAS.x - v.marker.a);
    }
    return ivec2(SH_EFFECT_NONE, 0);
}

TextVertex sh_text_vertex(vec3 pos, vec2 uv) {
    TextVertex v;
    v.marker = ivec4(texture(Sampler0, uv) * 255.0 + 0.5);
    v.atlasMarker = ivec4(texelFetch(Sampler0, ivec2(0, 0), 0) * 255.0 + 0.5);
    v.pos = pos;
    v.uv = uv;
    v.hasClipPos = false;
    v.clipPos = vec4(0.0);
    v.effect = ivec4(sh_text_classify(v), 0, 0);

    switch (v.effect.x) {
        case SH_EFFECT_ANIMATED_LOGO:
        animated_logo_vertex(v);
        break;

        case SH_EFFECT_SOLID_COLOR:
        solid_color_vertex(v);
        break;

        case SH_EFFECT_CROSSHAIR:
        crosshair_vertex(v);
        break;
    }

    shEffect = v.effect;
    return v;
}

#endif

#ifdef FSH

// Returns true if an effect fully shaded the fragment, vanilla shading is skipped then
bool sh_text_fragment(vec4 vertexColor, vec4 baseColor, vec2 uv, out vec4 result) {
    TextFragment f = TextFragment(vertexColor, baseColor, uv, shEffect);

    switch (f.effect.x) {
        case SH_EFFECT_ANIMATED_LOGO:
        return animated_logo_fragment(f, result);

        case SH_EFFECT_SOLID_COLOR:
        return solid_color_fragment(f, result);

        case SH_EFFECT_CROSSHAIR:
        return crosshair_fragment(f, result);
    }

    result = vec4(0.0);
    return false;
}

#endif

#endif
