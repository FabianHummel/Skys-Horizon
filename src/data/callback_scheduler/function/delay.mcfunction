$schedule function callback_scheduler:internal/delay/callback $(ticks)t append
$data modify storage cb in set value {ticks:$(ticks),selector:"$(selector)",command:"$(command)"}
function callback_scheduler:internal/delay/start
