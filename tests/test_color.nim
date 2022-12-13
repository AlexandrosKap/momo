import unittest
import momo/color

test "Color":
  check toByte("") == uint8.low
  check toByte("-") == uint8.low
  check toByte("67") != uint8.low
  check color(0, 0, 0, 0) == (0u8, 0u8, 0u8, 0u8)
  check color(0, 0, 0) == black
  check color(0) == black
  check color() == black
  check color("") == color(0)
  check color("-") == color(0)
  check color("67") == color(0)
  check color("e6d250") == color(230, 210, 80)
  check color("#e6d250") == color(230, 210, 80)
  check color("5aff5d78") == color(255, 93, 120, 90)
  check color("#5aff5d78") == color(255, 93, 120, 90)
