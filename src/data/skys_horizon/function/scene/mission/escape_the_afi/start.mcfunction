tag 5961a478-9659-419a-8827-dd175ede5bf9 remove skys_horizon.scene.location_check.active
tag @s remove skys_horizon.scene.location_check.5961a478-9659-419a-8827-dd175ede5bf9

execute at 3ee6de8e-da44-418f-8b4e-ec86d6fdb3ab run setblock ~ ~ ~ minecraft:barrier

function skys_horizon:scene/screen/display_solid_color {\
    fadeIn: 100,\
    stay: 41,\
    fadeOut: 0,\
    color: "black"\
}

function cb:schedule {\
    ticks: 140,\
    selector: "@s",\
    command: "function skys_horizon:scene/mission/show_mission_title_with_bg {\
        title: 'Chapter III',\
        subtitle: '- Escaping the AFI -'\
    }"\
}

function cb:schedule {\
    ticks: 200,\
    selector: "@s",\
    command: "execute at 3ee6de8e-da44-418f-8b4e-ec86d6fdb3ab run setblock ~ ~ ~ minecraft:air"\
}
