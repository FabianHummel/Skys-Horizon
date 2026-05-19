$title @s times $(duration)t 1d 0

$title @s title {\
    "text": "$(type)",\
    "font": "skys_horizon:crosshair",\
    "shadow_color": 0,\
    "color": "$(color)"\
}

$scoreboard players set $duration skys_horizon.crosshair $(duration)
