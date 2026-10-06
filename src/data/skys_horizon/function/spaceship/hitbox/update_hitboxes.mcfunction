execute unless entity @n[type=minecraft:armor_stand, tag=skys_horizon.spaceship.hitbox.hood, tag=!skys_horizon.spaceship.hitbox.placed] run function skys_horizon:spaceship/hitbox/create {\
    role: "hood",\
    scale: 1.2d,\
}

execute positioned ^.0 ^0.9 ^2 as @n[type=minecraft:armor_stand, tag=skys_horizon.spaceship.hitbox.hood, tag=!skys_horizon.spaceship.hitbox.placed] run function skys_horizon:spaceship/hitbox/place

execute unless entity @n[type=minecraft:armor_stand, tag=skys_horizon.spaceship.hitbox.hood, tag=!skys_horizon.spaceship.hitbox.placed] run function skys_horizon:spaceship/hitbox/create {\
    role: "hood",\
    scale: 1.2d,\
}

execute positioned ^.0 ^0.9 ^3.2 as @n[type=minecraft:armor_stand, tag=skys_horizon.spaceship.hitbox.hood, tag=!skys_horizon.spaceship.hitbox.placed] run function skys_horizon:spaceship/hitbox/place

execute unless entity @n[type=minecraft:armor_stand, tag=skys_horizon.spaceship.hitbox.hood, tag=!skys_horizon.spaceship.hitbox.placed] run function skys_horizon:spaceship/hitbox/create {\
    role: "hood",\
    scale: 1.2d,\
}

execute positioned ^.0 ^0.9 ^4.4 as @n[type=minecraft:armor_stand, tag=skys_horizon.spaceship.hitbox.hood, tag=!skys_horizon.spaceship.hitbox.placed] run function skys_horizon:spaceship/hitbox/place

execute unless entity @n[type=minecraft:armor_stand, tag=skys_horizon.spaceship.hitbox.hood, tag=!skys_horizon.spaceship.hitbox.placed] run function skys_horizon:spaceship/hitbox/create {\
    role: "hood",\
    scale: 1.2d,\
}

execute positioned ^.0 ^0.9 ^5.6 as @n[type=minecraft:armor_stand, tag=skys_horizon.spaceship.hitbox.hood, tag=!skys_horizon.spaceship.hitbox.placed] run function skys_horizon:spaceship/hitbox/place

execute unless entity @n[type=minecraft:armor_stand, tag=skys_horizon.spaceship.hitbox.rear, tag=!skys_horizon.spaceship.hitbox.placed] run function skys_horizon:spaceship/hitbox/create {\
    role: "rear",\
    scale: 2.5d,\
}

execute positioned ^.0 ^0.4 ^-2.8 as @n[type=minecraft:armor_stand, tag=skys_horizon.spaceship.hitbox.rear, tag=!skys_horizon.spaceship.hitbox.placed] run function skys_horizon:spaceship/hitbox/place
