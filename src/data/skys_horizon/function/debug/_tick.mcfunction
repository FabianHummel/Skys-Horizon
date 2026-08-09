execute if entity @p[gamemode=adventure] run function {
    team modify skys_horizon.no_collision seeFriendlyInvisibles false
}
execute if entity @p[gamemode=!adventure] run function {
    team modify skys_horizon.no_collision seeFriendlyInvisibles true
    gamerule minecraft:send_command_feedback true
}

execute if entity @p[gamemode=creative] run function {
    gamerule minecraft:send_command_feedback true
}
execute if entity @p[gamemode=!creative] run function {
    gamerule minecraft:send_command_feedback false
}
