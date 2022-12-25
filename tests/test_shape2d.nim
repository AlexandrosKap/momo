import unittest
import momo/shape2d

test "Shape2D":
  check circ2() == Circ2(position: vec2(), radius: 0)
