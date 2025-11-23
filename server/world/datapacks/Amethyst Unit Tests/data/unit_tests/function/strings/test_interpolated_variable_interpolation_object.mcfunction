# Created using Amethyst v1.0.1.0 on 2025-11-22.
data modify storage amethyst: 19 set value {keys:["key"],data:{"key":"value"}}
execute summon minecraft:text_display run function unit_tests:strings/test_interpolated_variable_interpolation_object/_use_text_display0
function unit_tests:strings/test_interpolated_variable_interpolation_object/_create_string0 with storage amethyst:
function amethyst:test/complete
