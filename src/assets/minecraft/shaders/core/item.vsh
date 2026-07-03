#version 330

#moj_import <minecraft:light.glsl>
#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:projection.glsl>
#moj_import <minecraft:sample_lightmap.glsl>
#moj_import <minecraft:globals.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV1;
in ivec2 UV2;
in vec3 Normal;

uniform sampler2D Sampler0;
uniform sampler2D Sampler1;
uniform sampler2D Sampler2;

out float sphericalVertexDistance;
out float cylindricalVertexDistance;
out vec4 vertexColor;
out vec4 lightMapColor;
out vec4 overlayColor;

out vec2 texCoord;

// Sky's Horizon
out vec3 Pos;
out vec2 atlasSize;
out vec4 baseColor;

#define SKYS_HORIZON_SPACE_SHADER
#define SKYS_HORIZON_ENTITY_SHADER
#define SKYS_HORIZON_SCENE_SHADER

#define VSH

// objmc
#moj_import <objmc:main.glsl>

// Sky's Horizon
#moj_import <skys_horizon:main.glsl>

#undef VSH

void main() {
    vertexColor = minecraft_mix_light(Light0_Direction, Light1_Direction, Normal, Color);
    lightMapColor = sample_lightmap(Sampler2, UV2);
    overlayColor = texelFetch(Sampler1, UV1, 0);

    // Sky's Horizon
    Pos = Position;
    texCoord = UV0;
    atlasSize = textureSize(Sampler0, 0);
    baseColor = Color;

    // objmc
    #moj_import <objmc:main.vsh>

    // Sky's Horizon
    #moj_import <skys_horizon:main.vsh>

    gl_Position = ProjMat * ModelViewMat * vec4(Pos, 1.0);

    sphericalVertexDistance = fog_spherical_distance(Pos);
    cylindricalVertexDistance = fog_cylindrical_distance(Pos);
}
