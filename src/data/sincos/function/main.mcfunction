## sin/cos
# input in degrees scaled by 1000 (1.000 -> 1000), outputs scaled by 100000 (1.00000 -> 100000)

## range reduction
# execute if score $in sincos matches 360001.. run scoreboard players operation $in sincos %= #360000 sincos
# execute if score $in sincos matches 180001.. run function sincos:bin/range/2
scoreboard players set $sinintx sincos 1
scoreboard players set $cosintx sincos 1
execute if score $in sincos matches ..-1 run function sincos:bin/range/1
execute if score $in sincos matches 90001.. run function sincos:bin/range/3

## binary search
# lookup sin(int(x)) and cos(int(x)) where int(x) is the integer portion of x
function sincos:bin/search/000
execute store result score $cos sincos run scoreboard players operation $sinintx sincos *= $sinl sincos
execute store result score $sin sincos run scoreboard players operation $cosintx sincos *= $cosl sincos

## linear interpolation
# sin(x) ~ (pi/180 * cos(int(x))) * (dx) + sin(int(x))
# where dx is difference between x and int(x)
scoreboard players operation $in sincos %= #1000 sincos
execute if score $in sincos matches 500.. run scoreboard players remove $in sincos 1000
scoreboard players operation $sin sincos *= $in sincos
scoreboard players operation $sin sincos /= #180000/pi sincos
scoreboard players operation $sin sincos += $sinintx sincos
# cos(x) ~ (pi/180 * -sin(int(x))) * (dx) + cos(int(x))
scoreboard players operation $cos sincos *= $in sincos
scoreboard players operation $cos sincos /= #-180000/pi sincos
scoreboard players operation $cos sincos += $cosintx sincos
