import unittest
import momo/vector

test "Vector":
  check vec2(2, 2) == Vec2(x: 2, y: 2)
  check vec2(1) == vec2(1, 1)
  check vec2() == vec2(0)
  check vec2(4) + vec2(2) == vec2(6)
  check -vec2(2) == vec2(-2)
  check vec2(4) - vec2(2) == vec2(2)
  check vec2(4) * vec2(2) == vec2(8)
  check vec2(4) / vec2(2) == vec2(2)
  check vec2(4) div vec2(2) == vec2(2)
  check vec2(4) mod vec2(2) == vec2(0)

  check vec3(1) == vec3(1, 1, 1)
  check vec3() == vec3(0)
  check vec3(4) + vec3(2) == vec3(6)
  check -vec3(2) == vec3(-2)
  check vec3(4) - vec3(2) == vec3(2)
  check vec3(4) * vec3(2) == vec3(8)
  check vec3(4) / vec3(2) == vec3(2)
  check vec3(4) div vec3(2) == vec3(2)
  check vec3(4) mod vec3(2) == vec3(0)

  check vec4(1) == vec4(1, 1, 1, 1)
  check vec4() == vec4(0)
  check vec4(4) + vec4(2) == vec4(6)
  check -vec4(2) == vec4(-2)
  check vec4(4) - vec4(2) == vec4(2)
  check vec4(4) * vec4(2) == vec4(8)
  check vec4(4) / vec4(2) == vec4(2)
  check vec4(4) div vec4(2) == vec4(2)
  check vec4(4) mod vec4(2) == vec4(0)

  check bvec2(false) + bvec2(true) == bvec2(true)
  check bvec2(false) * bvec2(true) == bvec2(false)