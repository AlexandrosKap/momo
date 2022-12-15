import math
import vector

# TODO: NOT DONE JUST TESTING THINGS

type
  EasingFunc = proc(x: float): float {.noSideEffect.}

# Easing functions

func ease*[T](function: EasingFunc, first, last: T, time: float): T =
  if time < 0.0: return first
  elif time > 1.0: return last
  when T is GVec2:
    gvec2(
      ease(function, first.x, last.x, time),
      ease(function, first.y, last.y, time)
    )
  elif T is GVec3:
    gvec3(
      ease(function, first.x, last.x, time),
      ease(function, first.y, last.y, time),
      ease(function, first.z, last.z, time)
    )
  elif T is GVec4:
    gvec4(
      ease(function, first.x, last.x, time),
      ease(function, first.y, last.y, time),
      ease(function, first.z, last.z, time),
      ease(function, first.w, last.w, time)
    )
  elif T is SomeInteger:
    first + ((last - first).float * function(time)).T
  else:
    first + (last - first) * function(time)

func linear*(x: float): float = x

func easeInSine*(x: float): float =
  sin((x - 1.0) * (PI / 2.0)) + 1.0
func easeOutSine*(x: float): float =
  sin(x * (PI / 2.0))
func easeInOutSine*(x: float): float =
  0.5 * (1.0 - cos(x * PI))

func easeInQuint*(x: float): float =
  pow(x, 5.0)
func easeOutQuint*(x: float): float =
  1.0 - pow(1.0 - x, 5.0)
func easeInOutQuint*(x: float): float =
  if x < 0.5: 16.0 * pow(x, 5.0) else: 1.0 - pow(-2.0 * x + 2.0, 5.0) / 2.0

# Testing part uwu
# x, y, time in [0.0, 1.0]

from os import sleep
var canBack = false
var i = 0.0
while true:
  echo ease(easeInOutSine, ivec2(0), ivec2(50, 100), i)
  if i > 1.0:
    canBack = true
  elif i < 0.0:
    canBack = false
  if canBack:
    i -= 0.0001
  else:
    i += 0.0001
  sleep(1)
