import unittest
import momo/shape2d

test "Shape2D":
  check circ2() == Circ2(position: vec2(), radius: 0)
  check circ2(0, 0, 0) == Circ2(position: vec2(), radius: 0)
  check circ2(vec2(0, 0), 0) == Circ2(position: vec2(), radius: 0)
  check circ2() + 1 == circ2(1, 1, 1)

  check rect2() == Rect2(position: vec2(), size: vec2())
  check rect2(0, 0, 0, 0) == Rect2(position: vec2(), size: vec2())
  check rect2(vec2(0, 0), vec2(0, 0)) == Rect2(position: vec2(), size: vec2())
  check rect2() + 1 == rect2(1, 1, 1, 1)

  check line2() == Line2(a: vec2(), b: vec2())
  check line2(0, 0, 0, 0) == Line2(a: vec2(), b: vec2())
  check line2(vec2(0, 0), vec2(0, 0)) == Line2(a: vec2(), b: vec2())
  check line2() + 1 == line2(1, 1, 1, 1)
