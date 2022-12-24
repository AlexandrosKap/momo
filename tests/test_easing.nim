import unittest
import momo/[color, easing, shape, vector]

test "Easing":
  for i in 0 .. 4:
    let f = i.float
    check lerp(0, 100, f * 0.25) == i * 25
    check lerp(0.0, 100.0, f * 0.25) == f * 25
    check lerp(vec2(), vec2(100), f * 0.25) == vec2(f * 25)
    check lerp(color(), color(100), f * 0.25) == color(i.uint8 * 25)

    check lerp(0, 100, f * 25, 100) == i * 25
    check lerp(0.0, 100.0, f * 25, 100) == f * 25
    check lerp(vec2(), vec2(100), f * 25, 100) == vec2(f * 25)
