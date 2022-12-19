# TODO: WORKING ON IT UWU
# TODO: MAKE IT WORK LIKE DOTWEEN?

type
  TweenGetter*[T, V] = proc(t: T): V
  TweenSetter*[T, V] = proc(t: T, v: V)

  Tween*[T, V] = ref object
    target: T
    getter: TweenGetter
    setter: TweenSetter
    first, last: V
    time: float
