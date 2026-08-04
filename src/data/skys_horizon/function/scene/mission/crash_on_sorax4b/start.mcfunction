function skys_horizon:scene/mission/show_mission_title_with_bg {\
    title: 'Chapter IV',\
    subtitle: '- What a World -'\
}

function cb:schedule {\
    ticks: 60,\
    selector: "@s",\
    command: "function skys_horizon:scene/screen/display_solid_color {\
        color: 'black',\
        fadeIn: 0,\
        stay: 0,\
        fadeOut: '13s'\
    }"\
}
