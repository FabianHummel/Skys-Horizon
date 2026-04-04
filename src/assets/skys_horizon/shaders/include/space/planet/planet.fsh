#if 0
void main()
#endif
{
    if (planetId != -1) {
        vec3 normal = normalize(cross(dFdx(Pos), dFdy(Pos)));
        color *= minecraft_mix_light(Light0_Direction, Light1_Direction, normal, overlayColor) * SUN_COLOR * ColorModulator;
        fragColor = color;
        return;
    }
}

#moj_import <skys_horizon:space/planet/atmosphere/atmosphere.fsh>
