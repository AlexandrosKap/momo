import unittest
import momo/color

proc testColor*() =
  check toByte("") == 0
  check toByte("-") == 0
  check toByte("67") != 0
  check color8(0, 0, 0, 0) == Color(x: 0, y: 0, z: 0, w: 0)
  check color8(0, 0, 0) == color8(0, 0, 0, 255)
  check color8(0) == color8(0, 0, 0)
  check color8() == color8(0)
  check color8("") == color8()
  check color8("-") == color8()
  check color8("67") == color8()
  check color8("e6d250") == color8(230, 210, 80)
  check color8("#e6d250") == color8(230, 210, 80)
  check color8("5aff5d78") == color8(255, 93, 120, 90)
  check color8("#5aff5d78") == color8(255, 93, 120, 90)
