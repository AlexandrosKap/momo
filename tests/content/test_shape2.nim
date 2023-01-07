import unittest
import momo/shape2

proc testShape2*() =
  let emptyCirc = Circ2(position: vec2(), radius: 0)
  let emptyRect = Rect2(position: vec2(), size: vec2())
  let emptyLine = Line2(a: vec2(), b: vec2())
  let emptyPoly = Poly2(position: vec2(), points: @[])

  check circ2(0, 0, 0) == emptyCirc
  check circ2(vec2(0, 0), 0) == emptyCirc
  check circ2() == emptyCirc

  check rect2(0, 0, 0, 0) == emptyRect
  check rect2(vec2(0, 0), vec2(0, 0)) == emptyRect
  check rect2() == emptyRect

  check line2(0, 0, 0, 0) == emptyLine
  check line2(vec2(0, 0), vec2(0, 0)) == emptyLine
  check line2() == emptyLine

  check newPoly2(0, 0, []) == emptyPoly
  check newPoly2(vec2(0, 0), []) == emptyPoly
  check newPoly2() == emptyPoly
