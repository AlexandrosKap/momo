import unittest
import momo/[color, easing, shape2d, vector]

test "Easing":
  for i in 0 .. 4:
    let f = i.float
    let ni = i.int32
    let nf = i.float32
    let nc = i.uint8

    check lerp(0, 100, f * 0.25) == i * 25
    check lerp(0.0, 100.0, f * 0.25) == f * 25
    check lerp(color(), color(100), f * 0.25) == color(nc * 25)
    check lerp(ivec2(), ivec2(100), f * 0.25) == ivec2(ni * 25)
    check lerp(vec2(), vec2(100), f * 0.25) == vec2(nf * 25)
    check lerp(
      circ2(),
      circ2(100, 100, 100), f * 0.25
    ) == circ2(nf * 25, nf * 25, nf * 25)

    check lerp(0, 100, f * 25, 100) == i * 25
    check lerp(0.0, 100.0, f * 25, 100) == f * 25
    check lerp(color(), color(100), f * 25, 100) == color(nc * 25)
    check lerp(ivec2(), ivec2(100), f * 25, 100) == ivec2(ni * 25)
    check lerp(vec2(), vec2(100), f * 25, 100) == vec2(nf * 25)
    check lerp(
      circ2(),
      circ2(100, 100, 100), f * 25, 100
    ) == circ2(nf * 25, nf * 25, nf * 25)
