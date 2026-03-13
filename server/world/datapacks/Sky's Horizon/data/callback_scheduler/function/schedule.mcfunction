data modify storage cb entities set value []
$execute as $(selector) run function callback_scheduler:internal/schedule/generate_uuid
$schedule function callback_scheduler:internal/schedule/callback $(ticks)t append
$data modify storage cb in set value {ticks:$(ticks),command:"$(command)"}
function callback_scheduler:internal/schedule/start
