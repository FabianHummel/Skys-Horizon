#version 330

#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:projection.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler0;
uniform sampler2D Sampler2;

out float sphericalVertexDistance;
out float cylindricalVertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;
out vec4 baseColor;

#define SKYS_HORIZON_SCREEN_SHADER

#define VSH

// Sky's Horizon
#moj_import <skys_horizon:main.glsl>

#undef VSH

void main() {
    sphericalVertexDistance = fog_spherical_distance(Position);
    cylindricalVertexDistance = fog_cylindrical_distance(Position);
    vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
    texCoord0 = UV0;
    baseColor = Color;

    // Sky's Horizon
    vec3 PositionTmp = Position;
    #moj_import <skys_horizon:main.vsh>

    gl_Position = ProjMat * ModelViewMat * vec4(PositionTmp, 1.0);
}
