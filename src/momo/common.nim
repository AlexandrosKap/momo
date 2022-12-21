from math import `mod`, floor

# Functions for bool

func `+`*(a, b: bool): bool =
  a or b

func `-`*(a: bool): bool =
  not a

func `-`*(a, b: bool): bool =
  a or not b

func `*`*(a, b: bool): bool =
  a and b

func `/`*(a, b: bool): bool =
  a and not b

func `div`*(a, b: bool): bool =
  a / b

func `mod`*(a, b: bool): bool =
  a / b

# Functions for numbers

func `/`*[T: SomeInteger](a, b: T): T =
  a div b

func `div`*[T: SomeFloat](a, b: T): T =
  (a / b).floor

func `mod`*[T: SomeFloat](a, b: T): T =
  a mod b
