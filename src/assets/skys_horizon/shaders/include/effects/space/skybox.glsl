#ifndef SKYS_HORIZON_EFFECTS_SPACE_SKYBOX_GLSL
#define SKYS_HORIZON_EFFECTS_SPACE_SKYBOX_GLSL

// effect.y = skybox variant
const int SKYBOX_STATIONARY = 0;
const int SKYBOX_SPACE = 1;

#ifdef VSH

void skybox_vertex(inout ItemVertex v) {
    if (v.effect.y != SKYBOX_SPACE) {
        return;
    }

    v.hasClipPos = true;

    // The first face alone is turned into a screen quad, all others are collapsed
    if (gl_VertexIndex >= 4) {
        v.clipPos = vec4(0.0);
        return;
    }

    vec2 cornerPos = SCREEN_CORNERS[gl_VertexIndex % 4];
    v.clipPos = vec4(cornerPos, 1.0, 2.0);

    vec4 rotation = conjugate(decodeRotationPrecise(v.data, v.yaw));
    cornerPos.x *= ScreenSize.x / ScreenSize.y;
    v.pos = normalize(rotate(vec3(cornerPos, -1.0), rotation));
}

#endif

#ifdef FSH

const vec2 SKYBOX_TEXTURE_SIZE = vec2(4096, 3072);

// https://en.wikipedia.org/wiki/File:Equirectangular_projection_SW.jpg
vec2 sphere2mapUV_Equirectangular(vec3 p) {
    return vec2(
        atan(p.x, -p.z) / (2.0 * SH_PI) + 0.5,
        p.y * 0.5 + 0.5
    );
}

bool skybox_fragment(ItemFragment f, out vec4 color) {
    vec3 p = -normalize(f.pos);
    vec2 uv = sphere2mapUV_Equirectangular(p) / f.atlasSize * SKYBOX_TEXTURE_SIZE + f.uv;
    // exclude marker-row
    uv.y += 1.0 / f.atlasSize.y;

    // Stars computation:
    vec3 stars_direction = p; // could be view vector for example
    float stars_threshold = 8.0; // modifies the number of stars that are visible
    float stars_exposure = 200.0; // modifies the overall strength of the stars
    float stars = pow(clamp(noise(stars_direction * 200.0), 0.0, 1.0), stars_threshold) * stars_exposure;
    stars *= mix(0.4, 1.4, noise(stars_direction * 100.0 + vec3(GameTime * 500.0))); // time based flickering

    color = max(texture(Sampler0, uv), vec4(vec3(stars), 1.0));
    return true;
}

#endif

#endif
