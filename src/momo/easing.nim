from math import PI, sqrt, pow, cos, sin
import color, vector

type EasingFunc* = proc(x: float): float {.noSideEffect.}

func ease*[T](function: EasingFunc, first, last: T, time: float): T =
  if time < 0.0: return first
  elif time > 1.0: return last
  when T is CVec2:
    gvec2(
      ease(function, first.x, last.x, time),
      ease(function, first.y, last.y, time)
    )
  elif T is CVec3:
    gvec3(
      ease(function, first.x, last.x, time),
      ease(function, first.y, last.y, time),
      ease(function, first.z, last.z, time)
    )
  elif T is CVec4:
    gvec4(
      ease(function, first.x, last.x, time),
      ease(function, first.y, last.y, time),
      ease(function, first.z, last.z, time),
      ease(function, first.w, last.w, time)
    )
  elif T is CColor:
    color(
      ease(function, first.r, last.r, time),
      ease(function, first.g, last.g, time),
      ease(function, first.b, last.b, time),
      ease(function, first.a, last.a, time)
    )
  elif T is SomeInteger:
    first + ((last - first).float * function(time)).T
  else:
    first + (last - first) * function(time)

func ease*[T](function: EasingFunc, first, last: T, time, maxTime: float): T =
  ease(
    function,
    first,
    last,
    if time < 0.0: 0.0 elif time > maxTime: 1.0 else: time / maxTime
  )

# Easing functions

func linear*(x: float): float = x

func easeInSine*(x: float): float = 1 - cos((x * PI) / 2.0)
func easeOutSine*(x: float): float = sin((x * PI) / 2.0)
func easeInOutSine*(x: float): float = -(cos(PI * x) - 1.0) / 2.0

func easeInQuad*(x: float): float =
  x * x
func easeOutQuad*(x: float): float =
  1.0 - (1.0 - x) * (1.0 - x)
func easeInOutQuad*(x: float): float =
  if x < 0.5: 2.0 * x * x else: 1.0 - pow(-2.0 * x + 2.0, 2.0) / 2.0

func easeInCubic*(x: float): float =
  x * x * x
func easeOutCubic*(x: float): float =
  1.0 - pow(1.0 - x, 3.0)
func easeInOutCubic*(x: float): float =
  if x < 0.5: 4.0 * x * x * x else: 1.0 - pow(-2.0 * x + 2.0, 3.0) / 2.0

func easeInQuart*(x: float): float =
  x * x * x * x
func easeOutQuart*(x: float): float =
  1.0 - pow(1.0 - x, 4.0)
func easeInOutQuart*(x: float): float =
  if x < 0.5: 8.0 * x * x * x * x else: 1.0 - pow(-2.0 * x + 2.0, 4.0) / 2.0

func easeInQuint*(x: float): float =
  x * x * x * x * x
func easeOutQuint*(x: float): float =
  1.0 - pow(1.0 - x, 5.0)
func easeInOutQuint*(x: float): float =
  if x < 0.5: 16.0 * x * x * x * x * x
  else: 1.0 - pow(-2.0 * x + 2.0, 5.0) / 2.0

func easeInExpo*(x: float): float =
  if x == 0.0: 0.0 else: pow(2.0, 10.0 * x - 10.0)
func easeOutExpo*(x: float): float =
  if x == 1.0: 1.0 else: 1.0 - pow(2.0, -10.0 * x)
func easeInOutExpo*(x: float): float =
  if x == 0.0: 0.0
  elif x == 1.0: 1.0
  elif x < 0.5: pow(2.0, 20.0 * x - 10.0) / 2.0
  else: (2.0 - pow(2.0, -20.0 * x + 10.0)) / 2.0

func easeInCirc*(x: float): float =
  1.0 - sqrt(1.0 - pow(x, 2.0))
func easeOutCirc*(x: float): float =
  sqrt(1.0 - pow(x - 1.0, 2.0))
func easeInOutCirc*(x: float): float =
  if x < 0.5: (1.0 - sqrt(1.0 - pow(2.0 * x, 2.0))) / 2.0
  else: (sqrt(1.0 - pow(-2.0 * x + 2.0, 2.0)) + 1.0) / 2.0

func easeInBack*(x: float): float =
  const c1 = 1.70158
  const c3 = c1 + 1.0
  c3 * x * x * x - c1 * x * x
func easeOutBack*(x: float): float =
  const c1 = 1.70158
  const c3 = c1 + 1.0
  1.0 + c3 * pow(x - 1.0, 3.0) + c1 * pow(x - 1.0, 2.0)
func easeInOutBack*(x: float): float =
  const c2 = 1.70158 * 1.525
  if x < 0.5:
    (pow(2.0 * x, 2.0) * ((c2 + 1.0) * 2.0 * x - c2)) / 2.0
  else:
    (pow(2.0 * x - 2.0, 2.0) * ((c2 + 1.0) * (x * 2.0 - 2.0) + c2) + 2.0) / 2.0

func easeInElastic*(x: float): float =
  const c4 = (2.0 * PI) / 3.0
  if x == 0.0: 0.0
  elif x == 1.0: 1.0
  else: -pow(2.0, 10.0 * x - 10.0) * sin((x * 10.0 - 10.75) * c4)
func easeOutElastic*(x: float): float =
  const c4 = (2.0 * PI) / 3.0
  if x == 0.0: 0.0
  elif x == 1.0: 1.0
  else: pow(2.0, -10.0 * x) * sin((x * 10.0 - 0.75) * c4) + 1.0
func easeInOutElastic*(x: float): float =
  const c5 = (2.0 * PI) / 4.5
  if x == 0.0:
    0.0
  elif x == 1.0:
    1.0
  elif x < 0.5:
    -(pow(2.0, 20.0 * x - 10.0) * sin((20.0 * x - 11.125) * c5)) / 2.0
  else:
    (pow(2.0, -20.0 * x + 10.0) * sin((20.0 * x - 11.125) * c5)) / 2.0 + 1.0

func easeOutBounce*(x: float): float =
  const n1 = 7.5625
  const d1 = 2.75
  if x < 1.0 / d1:
    n1 * x * x
  elif x < 2.0 / d1:
    let tx = x - 1.5
    n1 * (tx / d1) * tx + 0.75
  elif x < 2.5 / d1:
    let tx = x - 2.25
    n1 * (tx / d1) * tx + 0.9375
  else:
    let tx = x - 2.625
    n1 * (tx / d1) * tx + 0.984375
func easeInBounce*(x: float): float =
  1.0 - easeOutBounce(1.0 - x)
func easeInOutBounce*(x: float): float =
  if x < 0.5: (1.0 - easeOutBounce(1.0 - 2.0 * x)) / 2.0
  else: (1.0 + easeOutBounce(2.0 * x - 1.0)) / 2.0
