from strformat import `&`
import easing

# TODO: WORKING ON IT UWU

type
  Keyframe*[T] = object
    value*: T
    time*: float
    easingFunc*: EasingFunc
  Animation*[T] = ref object
    keyframes*: seq[Keyframe[T]]
    time*: float

func keyframe*[T](value: T, time: float, easingFunc: EasingFunc): Keyframe[T] =
  Keyframe[T](
    value: value,
    time: if time < 0.0: 0.0 else: time,
    easingFunc: easingFunc
  )

func keyframe*[T](value: T, time: float): Keyframe[T] =
  Keyframe[T](
    value: value,
    time: time,
    easingFunc: linear
  )

func ease*[T](self: Keyframe[T], last: Keyframe[T], time: float): T =
  if time < self.time: self.value
  elif time > last.time: last.value
  elif last.time < self.time: last.value
  else:
    ease(
      self.easingFunc,
      self.value,
      last.value,
      time - self.time,
      last.time - self.time
    )

func `$`*[T](self: Keyframe[T]): string =
  &"keyframe({self.value}, {self.time})"

func newAnimation*[T](keyframes: varargs[Keyframe[T]]): Animation[T] =
  result = Animation[T]()
  for keyframe in keyframes:
    result.keyframes.add(keyframe)

func duration*(self: Animation): float =
  if self.keyframes.len != 0:
    self.keyframes[^1].time
  else:
    0.0

func advance*(self: Animation, time: float) =
  self.time += time
  if self.time > self.duration:
    self.time = self.duration

func `$`*(self: Animation): string =
  result = ""
  for i, keyframe in self.keyframes:
    result.add(&"{i}: {keyframe}")
    if i != self.keyframes.len - 1:
      result.add('\n')
