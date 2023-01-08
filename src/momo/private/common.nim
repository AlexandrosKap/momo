from math import `mod`, floor
export `mod`

type
  SomeSignedNumber* = SomeSignedInt | SomeFloat

func `/`*[T: SomeInteger](a, b: T): T =
  a div b

func `div`*[T: SomeFloat](a, b: T): T =
  floor(a / b)
