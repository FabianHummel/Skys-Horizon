$function skys_horizon:scene/card_reader/spawn {\
    on_success: 'function skys_horizon:scene/airlock_door/open {\
        selector: \\"$(selector)\\",\
        activate_region:\\"$(activate_region)\\"\
    }'\
}
