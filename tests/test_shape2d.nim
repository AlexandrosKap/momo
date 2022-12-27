import unittest
import momo/shape2d

let emptyCirc2 = Circ2(position: vec2(), radius: 0)
let emptyRect2 = Rect2(position: vec2(), size: vec2())
let emptyLine2 = Line2(a: vec2(), b: vec2())
let emptyPoly2 = Poly2(position: vec2(), points: @[])

test "Shape2D":
  check circ2(0, 0, 0) == emptyCirc2
  check circ2(vec2(0, 0), 0) == emptyCirc2
  check circ2() == emptyCirc2

  check rect2(0, 0, 0, 0) == emptyRect2
  check rect2(vec2(0, 0), vec2(0, 0)) == emptyRect2
  check rect2() == emptyRect2

  check line2(0, 0, 0, 0) == emptyLine2
  check line2(vec2(0, 0), vec2(0, 0)) == emptyLine2
  check line2() == emptyLine2

  check newPoly2(0, 0, []) == emptyPoly2
  check newPoly2(vec2(0, 0), []) == emptyPoly2
  check newPoly2() == emptyPoly2
