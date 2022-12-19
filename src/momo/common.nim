from math import `mod`, floor

# Functions that make math stuff more easy.

func `+`*(a, b: bool): bool = a or b
func `*`*(a, b: bool): bool = a and b

func `*`*(a: SomeInteger, b: SomeFloat): SomeInteger = (a.SomeFloat * b).SomeInteger
func `/`*(a, b: SomeInteger): SomeInteger = a div b

func `div`*(a, b: SomeFloat): SomeFloat = (a / b).floor
func `mod`*(a, b: SomeFloat): SomeFloat = (a mod b).floor
