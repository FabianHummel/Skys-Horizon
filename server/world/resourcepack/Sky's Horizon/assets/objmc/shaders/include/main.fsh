//objmc
//https://github.com/Godlander/objmc

//default lighting
if (isObjmcModel == 0) {
    color *= vertexColor * ColorModulator;
#ifndef EMISSIVE
    color *= lightColor;
#endif
#ifndef NO_OVERLAY
    color.rgb = mix(overlayColor.rgb, color.rgb, overlayColor.a);
#endif
}
//custom lighting
else {
    //normal from position derivatives
    vec3 normal = normalize(cross(dFdx(Pos), dFdy(Pos)));
    color *= minecraft_mix_light(Light0_Direction, Light1_Direction, normal, overlayColor) * lightColor * ColorModulator;
}
