from math import `mod`, floor
export `mod`

# Boolean Functions

func `+`*(a, b: bool): bool =
  a or b

func `*`*(a, b: bool): bool =
  a and b

# Number Functions

func `/`*[T: SomeInteger](a, b: T): T =
  a div b

func `div`*[T: SomeFloat](a, b: T): T =
  floor(a / b)
