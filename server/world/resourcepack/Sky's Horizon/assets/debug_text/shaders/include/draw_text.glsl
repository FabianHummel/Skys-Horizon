const float LOG10 = 1./log(10.);

int[] digits = int[](31599, 11410, 10839, 25230, 23497, 31182, 31215, 29330, 31407, 31695);
const int _A = 11245;
const int _B = 27566;
const int _C = 14627;
const int _D = 27502;
const int _E = 31143;
const int _F = 31140;
const int _G = 31087;
const int _H = 23533;
const int _I = 8338;
const int _J = 4719;
const int _K = 23469;
const int _L = 18727;
const int _M = 24429;
const int _N = 31597;
const int _O = 31599;
const int _P = 31716;
const int _Q = 31609;
const int _R = 31661;
const int _S = 31183;
const int _T = 29842;
const int _U = 23407;
const int _V = 23402;
const int _W = 23421;
const int _X = 23213;
const int _Y = 23186;
const int _Z = 29351;
const int _a = 3711;
const int _b = 2543;
const int _c = 3879;
const int _d = 1007;
const int _e = 4071;
const int _f = 1722;
const int _g = 1782;
const int _h = 2541;
const int _i = 1042;
const int _j = 1046;
const int _k = 2421;
const int _l = 1169;
const int _m = 3053;
const int _n = 3437;
const int _o = 3951;
const int _p = 1746;
const int _q = 1737;
const int _r = 1682;
const int _s = 1806;
const int _t = 1234;
const int _u = 2927;
const int _v = 2922;
const int _w = 2941;
const int _x = 2733;
const int _y = 3022;
const int _z = 3671;
const int _MINUS = 448;
const int _COLON = 2080;
const int _EQUALS = 3640;
const int _COMMA = 20;
const int _DOT = 4;
const int _PAR_O = 10530;
const int _PAR_C = 8778;
const int _SPACE = 0;
const int _SEMICOLON = 1044;


void drawChar(inout float state, vec2 uv, int bitmap) {
    ivec2 iuv = ivec2(floor(uv));
    if (iuv.x < 0 || iuv.y < 0 || iuv.x > 2 || iuv.y > 6) {
        return;
    }
    int bit = bitmap >> (2-iuv.x + iuv.y * 3);
    if ((bit & 1) == 1) {
        state = 1.0;
    }
}

#define drawString(state, uv, string) for (int i = 0; i < string.length(); i++) {drawChar(state, uv, string[i]); uv.x -= 4.0;}
void drawInt(inout float state, inout vec2 uv, int n) {
    if (n == 0) {
        drawChar(state, uv, digits[0]);
        uv.x -= 4.;
        return;
    }
    vec2 newUV = uv;
    if (n < 0) {
        drawChar(state, uv, _MINUS);
        uv.x -= 4.;
        n = -n;
    }
    float numLength = floor(LOG10 * log(float(n)) + 1.);
    uv.x -= 4. * numLength;
    vec2 cursor = uv;
    while (n > 0) {
        cursor.x += 4.;
        drawChar(state, cursor, digits[n % 10]);
        n /= 10;
    }
}

void drawFloat(inout float state, inout vec2 uv, float f) {
    if (isnan(f)) {
        int[] str = int[](_N, _a, _N);
        drawString(state, uv, str);
        return;
    }
    if (f < 0.) {
        drawChar(state, uv, _MINUS);
        uv.x -= 4.;
        f = abs(f);
    }
    float tr = floor(f);
    float fr = fract(f);
    drawInt(state, uv, int(tr));
    drawChar(state, uv, _DOT);
    uv.x -= 4.;
    for (int i = 0; i < 6; i++) {
        fr *= 10.;
        drawChar(state, uv, digits[int(fr)]);
        uv.x -= 4.;
        fr = fract(fr);
        if (fr < 1e-7) return;
    }
}

void drawVec2(inout float state, inout vec2 uv, vec2 v) {
    int[] str1 = int[](_v,_e,_c,digits[2],_PAR_O);
    drawString(state, uv, str1);
    drawFloat(state, uv, v.x);
    drawChar(state, uv, _COMMA);
    uv.x -= 4.;
    drawChar(state, uv, _SPACE);
    uv.x -= 4.;
    drawFloat(state, uv, v.y);
    drawChar(state, uv, _PAR_C);
    uv.x -= 4.;
}

void drawGlobals(inout float state, vec2 uv) {
    vec2 cursor = uv;
    int[] str1 = int[](_S,_c,_r,_e,_e,_n,_S,_i,_z,_e,_SPACE,_EQUALS,_SPACE);
    drawString(state, cursor, str1);
    drawVec2(state, cursor, ScreenSize);

    cursor = uv;
    cursor.y += 6.;
    int[] str2 = int[](_G,_l,_i,_n,_t,_A,_l,_p,_h,_a,_SPACE,_EQUALS,_SPACE);
    drawString(state, cursor, str2);
    drawFloat(state, cursor, GlintAlpha);

    cursor = uv;
    cursor.y += 12.;
    int[] str3 = int[](_G,_a,_m,_e,_T,_i,_m,_e,_SPACE,_EQUALS,_SPACE);
    drawString(state, cursor, str3);
    drawFloat(state, cursor, GameTime);

    cursor = uv;
    cursor.y += 18.;
    int[] str4 = int[](_M,_e,_n,_u,_B,_l,_u,_r,_R,_a,_d,_i,_u,_s,_SPACE,_EQUALS,_SPACE);
    drawString(state, cursor, str4);
    drawInt(state, cursor, MenuBlurRadius);
}
