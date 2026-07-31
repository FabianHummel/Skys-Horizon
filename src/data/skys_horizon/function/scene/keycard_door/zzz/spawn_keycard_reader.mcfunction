$function skys_horizon:scene/card_reader/spawn {\
    on_success: "execute as $(marker_uuid) at @s run function skys_horizon:scene/keycard_door/zzz/open_door",\
    key: "$(key)"\
}
