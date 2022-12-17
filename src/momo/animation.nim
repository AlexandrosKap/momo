import easing

# TODO: WORKING ON IT UWU

type
  Keyframe*[T] = object
    value*: T
    time*: float
    easingFunc*: EasingFunc
  Animation* = ref object # working on it...

func keyframe*[T](value: T, time: float, easingFunc: EasingFunc): Keyframe[T] =
  Keyframe(
    value: value,
    time: if time < 0.0: 0.0 else: time,
    easingFunc: easingFunc
  )

func keyframe*[T](value: T, easingFunc: EasingFunc): Keyframe[T] =
  Keyframe(
    value: value,
    time: 0.0,
    easingFunc: easingFunc
  )

func keyframe*[T](value: T): Keyframe[T] =
  Keyframe(
    value: value,
    time: 0.0,
    easingFunc: linear
  )

func ease*[T](first: Keyframe[T], last: Keyframe[T], time: float): T =
  if time < first.time: first.value
  elif time > last.time: last.value
  elif last.time < first.time: last.value
  else:
    ease(
      first.easingFunc,
      first.value,
      last.value,
      time - first.time,
      last.time - first.time
    )
