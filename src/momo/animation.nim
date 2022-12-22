from strformat import `&`
import easing

# TODO: WORKING ON IT UWU

type
  Keyframe*[T: SomeEasingType] = object
    easingFunc*: EasingFunc
    value*: T
    time*: float
  Animation*[T: SomeEasingType] = ref object
    keyframes*: seq[Keyframe[T]]
    index: uint
    time: float

func keyframe*[T: SomeEasingType](
  easingFunc: EasingFunc, value: T, time: float
): Keyframe[T] =
  Keyframe[T](
    easingFunc: easingFunc,
    value: value,
    time: if time < 0.0: 0.0 else: time,
  )

func keyframe*[T: SomeEasingType](
  value: T, time: float
): Keyframe[T] =
  Keyframe[T](
    easingFunc: linear,
    value: value,
    time: time,
  )

func ease*[T: SomeEasingType](
  self: Keyframe[T], last: Keyframe[T], time: float
): T =
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

func `$`*[T: SomeEasingType](self: Keyframe[T]): string =
  &"keyframe({self.value}, {self.time})"

func newAnimation*[T: SomeEasingType](
  keyframes: varargs[Keyframe[T]]
): Animation[T] =
  result = Animation[T]()
  for keyframe in keyframes:
    result.keyframes.add(keyframe)

func len*(self: Animation): int =
  self.keyframes.len

func duration*(self: Animation): float =
  if self.keyframes.len != 0:
    self.keyframes[^1].time
  else:
    0.0

func setTime(self: Animation, time: float) =
  if time < 0.0: self.time = 0.0
  elif time > self.duration: self.time = self.duration
  else: self.time = time

func updateIndex(self: Animation) =
  let duration = self.duration
  if duration > 0.0:
    if self.time == 0:
      self.index = 0
    elif self.time == duration:
      self.index = self.len - 1
    # TODO: JDAWJDODJO

func advance*(self: Animation, time: float) =
  self.setTime(self.time + time)
  self.updateIndex()

func `$`*(self: Animation): string =
  result = ""
  for i, keyframe in self.keyframes:
    result.add(&"{i}: {keyframe}")
    if i != self.keyframes.len - 1:
      result.add('\n')
