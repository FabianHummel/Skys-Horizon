#if 0
void main()
#endif
{
    if (isSkyboxMarker == 1) {
        vec3 p = -normalize(Pos);
        vec2 uv = sphere2mapUV_Equirectangular(p) / atlasSize * SKYBOX_TEXTURE_SIZE + texCoord;
        // exclude marker-row
        uv.y += 1. / atlasSize.y;
        fragColor = texture(Sampler0, uv);
        // Stars computation:
        // vec3 stars_direction = normalize(vec3(uv * 2.0f - 1.0f, 1.0f)); // could be view vector for example
        // float stars_threshold = 8.0f; // modifies the number of stars that are visible
        // float stars_exposure = 200.0f; // modifies the overall strength of the stars
        // float stars = pow(clamp(noise(stars_direction * 200.0f), 0.0f, 1.0f), stars_threshold) * stars_exposure;
        // stars *= mix(0.4, 1.4, noise(stars_direction * 100.0f + vec3(GameTime * 500.0))); // time based flickering
        // fragColor = vec4(vec3(stars), 1.0);

        return;
    }
}
