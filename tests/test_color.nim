import unittest
import momo/color

test "Color":
  check toByte("") == 0
  check toByte("-") == 0
  check toByte("67") != 0
  check color(0, 0, 0, 0) == Color(r: 0, g: 0, b: 0, a: 0)
  check color(0, 0, 0) == color(0, 0, 0, 255)
  check color(0) == color(0, 0, 0)
  check color() == color(0)
  check color("") == color()
  check color("-") == color()
  check color("67") == color()
  check color("e6d250") == color(230, 210, 80)
  check color("#e6d250") == color(230, 210, 80)
  check color("5aff5d78") == color(255, 93, 120, 90)
  check color("#5aff5d78") == color(255, 93, 120, 90)

  check color(255) + color(255) == color(255)
  check color(0) - color(255) == color(0, 0, 0, 0)
  check color(255) * color(255) == color(255)
  check color(255) / color(255) == color(1, 1, 1, 1)
  check color(255) div color(255) == color(1, 1, 1, 1)
  check color(255) mod color(255) == color(0, 0, 0, 0)
  check color(4) * 2 == color(8)
  check color(4) * 0.5 == color(2, 2, 2, (255 * 0.5).uint8)
  check color(4) / 2 == color(2, 2, 2, (255 / 2).uint8)
  check color(4) / 2.0 == color(2, 2, 2, (255 / 2.0).uint8)
