#if 0
void main()
#endif
{
    const float TRANSPARENCY = 0.7;

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

        case 3:
        #moj_import <skys_horizon:screen/crosshair/crosshairs/task_cancel.fsh>
        return;

        case 4:
        #moj_import <skys_horizon:screen/crosshair/crosshairs/progress_cancel.fsh>
        return;
    }
}
