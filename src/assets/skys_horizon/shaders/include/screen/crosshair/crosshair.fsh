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
        #moj_import <skys_horizon:screen/crosshair/crosshairs/default.fsh>
        return;

        case 1:
        #moj_import <skys_horizon:screen/crosshair/crosshairs/task.fsh>
        return;

        case 2:
        #moj_import <skys_horizon:screen/crosshair/crosshairs/progress.fsh>
        return;
    }
}
