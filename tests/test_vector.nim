import unittest
import momo/vector

test "Vector":
  check vec2(2, 2) == (2f32, 2f32)
  check vec2(1) == (1f32, 1f32)
  check vec2() == (0f32, 0f32)
