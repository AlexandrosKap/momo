import unittest
import momo/color

proc testColor*() =
  check toByte("") == 0
  check toByte("-") == 0
  check toByte("67") != 0
  check color(0, 0, 0, 0) == Color(x: 0, y: 0, z: 0, w: 0)
  check color(0, 0, 0) == color(0, 0, 0, 1)
  check color(0) == color(0, 0, 0, 1)
  check color("") == color()
  check color("-") == color()
  check color("67") == color()
  check color("e6d250") == color8(230, 210, 80)
  check color("#e6d250") == color8(230, 210, 80)
  check color("5aff5d78") == color8(255, 93, 120, 90)
  check color("#5aff5d78") == color8(255, 93, 120, 90)
