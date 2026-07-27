title @s clear

function skys_horizon:scene/intro/display_solid_color {\
    color: "#fafafa",\
    fadeIn: "10s",\
    stay: "300s",\
    fadeOut: "0"\
}

function cb:schedule {\
    ticks: 250,\
    selector: "@s",\
    command: "function skys_horizon:scene/intro/display_logo"\
}

function cb:schedule {\
    ticks: 6000,\
    selector: "@s",\
    command: "function skys_horizon:scene/intro/play_crash_scene"\
}
