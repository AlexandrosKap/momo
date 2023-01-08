from math import `mod`
export `mod`

type
  SomeSignedNumber* = SomeSignedInt | SomeFloat

func `/`*[T: SomeInteger](a, b: T): T {.inline.} =
  a div b

func `div`*[T: SomeFloat](a, b: T): T {.inline.} =
  a / b
