from math import `mod`, floor

# Functions that make math stuff easy.

func `+`*(a, b: bool): bool =
  a or b

func `*`*(a, b: bool): bool =
  a and b

func `+`*(a: SomeInteger, b: SomeFloat): SomeInteger =
  a + b.SomeInteger

func `-`*(a: SomeInteger, b: SomeFloat): SomeInteger =
  a - b.SomeInteger

func `*`*(a: SomeInteger, b: SomeFloat): SomeInteger =
  (a.SomeFloat * b).SomeInteger

func `/`*(a: SomeInteger, b: SomeFloat): SomeInteger =
  (a.SomeFloat / b).SomeInteger

func `/`*(a, b: SomeInteger): SomeInteger =
  a div b

func `/`*(a: SomeUnsignedInt, b: SomeSignedInt): SomeUnsignedInt =
  (a.SomeSignedInt div b).SomeUnsignedInt

func `+`*(a: SomeFloat, b: SomeInteger): SomeFloat =
  a + b.SomeFloat

func `-`*(a: SomeFloat, b: SomeInteger): SomeFloat =
  a - b.SomeFloat

func `*`*(a: SomeFloat, b: SomeInteger): SomeFloat =
  a * b.SomeFloat

func `/`*(a: SomeFloat, b: SomeInteger): SomeFloat =
  a / b.SomeFloat

func `div`*(a, b: SomeFloat): SomeFloat =
  (a / b).floor

func `mod`*(a, b: SomeFloat): SomeFloat =
  a mod b
