import unittest
import momo/[easing, shape2, vector]

proc testEasign*() =
  let lastVec = vec2(100)
  let lastCirc = circ2(100, 100, 100)

  for i in 0 .. 4:
    let f = i.float

    check lerp(0, 100, f * 0.25) == i * 25
    check lerp(0.0, 100.0, f * 0.25) == f * 25
    check lerp(vec2(), lastVec, f * 0.25) == vec2(f * 25)
    check lerp(circ2(), lastCirc, f * 0.25) == circ2(f * 25, f * 25, f * 25)
    check lerp(0, 100, f * 25, 100) == i * 25
