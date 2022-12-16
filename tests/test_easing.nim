import unittest
import momo/[color, easing, vector]

test "Easing":
  for i in 0 .. 4:
    check ease(linear, 0, 100, i.float * 0.25) == i * 25
    check ease(linear, 0.0, 100.0, i.float * 0.25) == i.float * 25.0
    check ease(linear, vec2(), vec2(100), i.float * 0.25) == vec2(i.float32 * 25.0)
    check ease(linear, color(), color(100), i.float * 0.25) == color(i.uint8 * 25)

    check ease(linear, 0, 100, i.float * 25.0, 100) == i * 25
    check ease(linear, 0.0, 100.0, i.float * 25.0, 100) == i.float * 25.0
    check ease(linear, vec2(), vec2(100), i.float * 25.0, 100) == vec2(
        i.float32 * 25.0)
    check ease(linear, color(), color(100), i.float * 25.0, 100) == color(
        i.uint8 * 25)
