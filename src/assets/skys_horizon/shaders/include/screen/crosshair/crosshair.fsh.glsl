#if 0
void main()
#endif
{
    const float PI = 3.1415926535897932;

    const float TRANSPARENCY = 0.6;
    const float EMPTY_ALPHA = 0.7;
    const float FILLED_ALPHA = 0.9;

    const float FROM_RADIUS = 0.15;
    const float OUTER_RADIUS = 0.8;
    const float WIDTH = 0.2;
    const float INNER_RADIUS = OUTER_RADIUS - WIDTH;

    switch (crosshairId) {
        case 0:
        #include <skys_horizon:screen/crosshair/crosshairs/default.fsh.glsl>
        return;

        case 1:
        #include <skys_horizon:screen/crosshair/crosshairs/task.fsh.glsl>
        return;

        case 2:
        #include <skys_horizon:screen/crosshair/crosshairs/progress.fsh.glsl>
        return;
    }
}
