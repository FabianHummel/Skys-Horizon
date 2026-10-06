execute if entity @p[gamemode=adventure] run function {
    team modify skys_horizon.no_collision seeFriendlyInvisibles false
}
execute if entity @p[gamemode=!adventure] run function {
    team modify skys_horizon.no_collision seeFriendlyInvisibles true
    gamerule send_command_feedback true
}

execute if entity @p[gamemode=creative] run function {
    gamerule send_command_feedback true
}
execute if entity @p[gamemode=!creative] run function {
    gamerule send_command_feedback false
}
