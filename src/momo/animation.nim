import easing

# TODO: WORKING ON IT UWU

type
  Keyframe*[T] = object
    value*: T
    time*: float
    function*: EasingFunc

func keyframe*[T](value: T, time: float, function: EasingFunc): Keyframe[T] =
  Keyframe(
    value: value,
    time: if time < 0.0: 0.0 else: time,
    function: function
  )

func keyframe*[T](value: T, function: EasingFunc): Keyframe[T] =
  Keyframe(
    value: value,
    time: 0.0,
    function: function
  )

func keyframe*[T](value: T): Keyframe[T] =
  Keyframe(
    value: value,
    time: 0.0,
    function: linear
  )
