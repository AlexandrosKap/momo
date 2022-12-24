import unittest
import momo/[color, easing, shape, vector]

test "Easing":
  for i in 0 .. 4:
    let f = i.float
    let ni = i.int32
    let nf = i.float32

    check lerp(0, 100, f * 0.25) == i * 25
    check lerp(0.0, 100.0, f * 0.25) == f * 25
    check lerp(ivec2(), ivec2(100), f * 0.25) == ivec2(ni * 25)
    check lerp(vec2(), vec2(100), f * 0.25) == vec2(nf * 25)

    check lerp(0, 100, f * 25, 100) == i * 25
    check lerp(0.0, 100.0, f * 25, 100) == f * 25
    check lerp(ivec2(), ivec2(100), f * 25, 100) == ivec2(ni * 25)
    check lerp(vec2(), vec2(100), f * 25, 100) == vec2(nf * 25)
