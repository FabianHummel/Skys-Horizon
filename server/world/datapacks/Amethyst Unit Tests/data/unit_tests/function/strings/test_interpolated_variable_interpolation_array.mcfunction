# Created using Amethyst v1.0.1.0 on 2025-11-22.
data modify storage amethyst: 16 set value [1,2,3]
execute summon minecraft:text_display run function unit_tests:strings/test_interpolated_variable_interpolation_array/_use_text_display0
function unit_tests:strings/test_interpolated_variable_interpolation_array/_create_string0 with storage amethyst:
function amethyst:test/complete
