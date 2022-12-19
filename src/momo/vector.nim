from strformat import `&`
import common

type
  CVec2*[T] = concept vec
    vec.x is T
    vec.y is T
  GVec2*[T] = object
    x*, y*: T
  BVec2* = GVec2[bool]
  IVec2* = GVec2[int32]
  UVec2* = GVec2[uint32]
  Vec2* = GVec2[float32]
  DVec2* = GVec2[float64]

  CVec3*[T] = concept vec
    vec.x is T
    vec.y is T
    vec.z is T
  GVec3*[T] = object
    x*, y*, z*: T
  BVec3* = GVec3[bool]
  IVec3* = GVec3[int32]
  UVec3* = GVec3[uint32]
  Vec3* = GVec3[float32]
  DVec3* = GVec3[float64]

  CVec4*[T] = concept vec
    vec.x is T
    vec.y is T
    vec.z is T
    vec.w is T
  GVec4*[T] = object
    x*, y*, z*, w*: T
  BVec4* = GVec4[bool]
  IVec4* = GVec4[int32]
  UVec4* = GVec4[uint32]
  Vec4* = GVec4[float32]
  DVec4* = GVec4[float64]

# Constructors for GVec2

func gvec2*[T](x, y: T): GVec2[T] = GVec2[T](x: x, y: y)
func bvec2*(x, y: bool): BVec2 = gvec2(x, y)
func ivec2*(x, y: int32): IVec2 = gvec2(x, y)
func uvec2*(x, y: uint32): UVec2 = gvec2(x, y)
func vec2*(x, y: float32): Vec2 = gvec2(x, y)
func dvec2*(x, y: float64): DVec2 = gvec2(x, y)

func gvec2*[T](x: T): GVec2[T] = gvec2(x, x)
func bvec2*(x: bool): BVec2 = gvec2(x)
func ivec2*(x: int32): IVec2 = gvec2(x)
func uvec2*(x: uint32): UVec2 = gvec2(x)
func vec2*(x: float32): Vec2 = gvec2(x)
func dvec2*(x: float64): DVec2 = gvec2(x)

func gvec2*[T](): GVec2[T] = gvec2(T.default, T.default)
func bvec2*(): BVec2 = gvec2[bool]()
func ivec2*(): IVec2 = gvec2[int32]()
func uvec2*(): UVec2 = gvec2[uint32]()
func vec2*(): Vec2 = gvec2[float32]()
func dvec2*(): DVec2 = gvec2[float64]()

# Operators for GVec2

func `==`*[T](a, b: GVec2[T]): bool =
  a.x == b.x and a.y == b.y

func `!=`*[T](a, b: GVec2[T]): bool =
  not (a == b)

func `+`*[T](a, b: GVec2[T]): GVec2[T] =
  gvec2[T](a.x + b.x, a.y + b.y)

func `-`*[T](a: GVec2[T]): GVec2[T] =
  gvec2[T](-a.x, -a.y)

func `-`*[T](a, b: GVec2[T]): GVec2[T] =
  gvec2[T](a.x - b.x, a.y - b.y)

func `*`*[T](a: GVec2[T], b: SomeNumber): GVec2[T] =
  gvec2[T](a.x * b, a.y * b)

func `*`*[T](a: SomeNumber, b: GVec2[T]): GVec2[T] =
  gvec2[T](b.x * a, b.y * a)

func `*`*[T](a, b: GVec2[T]): GVec2[T] =
  gvec2[T](a.x * b.x, a.y * b.y)

func `/`*[T](a: GVec2[T], b: SomeNumber): GVec2[T] =
  gvec2[T](a.x / b, a.y / b)

func `/`*[T](a: SomeNumber, b: GVec2[T]): GVec2[T] =
  gvec2[T](b.x / a, b.y / a)

func `/`*[T](a, b: GVec2[T]): GVec2[T] =
  gvec2[T](a.x / b.x, a.y / b.y)

func `div`*[T](a: GVec2[T], b: SomeNumber): GVec2[T] =
  gvec2[T](a.x div b, a.y div b)

func `div`*[T](a: SomeNumber, b: GVec2[T]): GVec2[T] =
  gvec2[T](b.x div a, b.y div a)

func `div`*[T](a, b: GVec2[T]): GVec2[T] =
  gvec2[T](a.x div b.x, a.y div b.y)

func `mod`*[T](a: GVec2[T], b: SomeNumber): GVec2[T] =
  gvec2[T](a.x mod b, a.y mod b)

func `mod`*[T](a: SomeNumber, b: GVec2[T]): GVec2[T] =
  gvec2[T](b.x mod a, b.y mod a)

func `mod`*[T](a, b: GVec2[T]): GVec2[T] =
  gvec2[T](a.x mod b.x, a.y mod b.y)

func `+=`*[T](a: var GVec2[T], b: GVec2[T]) =
  a = a + b

func `-=`*[T](a: var GVec2[T], b: GVec2[T]) =
  a = a - b

func `*=`*[T](a: var GVec2[T], b: SomeNumber) =
  a = a * b

func `*=`*[T](a: var GVec2[T], b: GVec2[T]) =
  a = a * b

func `/=`*[T](a: var GVec2[T], b: SomeNumber) =
  a = a / b

func `/=`*[T](a: var GVec2[T], b: GVec2[T]) =
  a = a / b

func `div=`*[T](a: var GVec2[T], b: SomeNumber) =
  a = a div b

func `div=`*[T](a: var GVec2[T], b: GVec2[T]) =
  a = a div b

func `mod=`*[T](a: var GVec2[T], b: SomeNumber) =
  a = a mod b

func `mod=`*[T](a: var GVec2[T], b: GVec2[T]) =
  a = a mod b

# String functions for GVec2

func `$`*(self: BVec2): string =
  &"bvec2({self.x}, {self.y})"

func `$`*(self: IVec2): string =
  &"ivec2({self.x}, {self.y})"

func `$`*(self: UVec2): string =
  &"uvec2({self.x}, {self.y})"

func `$`*(self: Vec2): string =
  &"vec2({self.x}, {self.y})"

func `$`*(self: DVec2): string =
  &"dvec2({self.x}, {self.y})"

# Constructors for GVec3

func gvec3*[T](x, y, z: T): GVec3[T] = GVec3[T](x: x, y: y, z: z)
func bvec3*(x, y, z: bool): BVec3 = gvec3(x, y, z)
func ivec3*(x, y, z: int32): IVec3 = gvec3(x, y, z)
func uvec3*(x, y, z: uint32): UVec3 = gvec3(x, y, z)
func vec3*(x, y, z: float32): Vec3 = gvec3(x, y, z)
func dvec3*(x, y, z: float64): DVec3 = gvec3(x, y, z)

func gvec3*[T](x: T): GVec3[T] = gvec3(x, x, x)
func bvec3*(x: bool): BVec3 = gvec3(x)
func ivec3*(x: int32): IVec3 = gvec3(x)
func uvec3*(x: uint32): UVec3 = gvec3(x)
func vec3*(x: float32): Vec3 = gvec3(x)
func dvec3*(x: float64): DVec3 = gvec3(x)

func gvec3*[T](): GVec3[T] = gvec3(T.default, T.default, T.default)
func bvec3*(): BVec3 = gvec3[bool]()
func ivec3*(): IVec3 = gvec3[int32]()
func uvec3*(): UVec3 = gvec3[uint32]()
func vec3*(): Vec3 = gvec3[float32]()
func dvec3*(): DVec3 = gvec3[float64]()

# Operators for GVec3

func `==`*[T](a, b: GVec3[T]): bool =
  a.x == b.x and a.y == b.y and a.z == b.z

func `!=`*[T](a, b: GVec3[T]): bool =
  not (a == b)

func `+`*[T](a, b: GVec3[T]): GVec3[T] =
  gvec3[T](a.x + b.x, a.y + b.y, a.z + b.z)

func `-`*[T](a: GVec3[T]): GVec3[T] =
  gvec3[T](-a.x, -a.y, -a.z)

func `-`*[T](a, b: GVec3[T]): GVec3[T] =
  gvec3[T](a.x - b.x, a.y - b.y, a.z - b.z)

func `*`*[T](a: GVec3[T], b: SomeNumber): GVec3[T] =
  gvec3[T](a.x * b, a.y * b, a.z * b)

func `*`*[T](a: SomeNumber, b: GVec3[T]): GVec3[T] =
  gvec3[T](b.x * a, b.y * a, b.z * a)

func `*`*[T](a, b: GVec3[T]): GVec3[T] =
  gvec3[T](a.x * b.x, a.y * b.y, a.z * b.z)

func `/`*[T](a: GVec3[T], b: SomeNumber): GVec3[T] =
  gvec3[T](a.x / b, a.y / b, a.z / b)

func `/`*[T](a: SomeNumber, b: GVec3[T]): GVec3[T] =
  gvec3[T](b.x / a, b.y / a, b.z / a)

func `/`*[T](a, b: GVec3[T]): GVec3[T] =
  gvec3[T](a.x / b.x, a.y / b.y, a.z / b.z)

func `div`*[T](a: GVec3[T], b: SomeNumber): GVec3[T] =
  gvec3[T](a.x div b, a.y div b, a.z div b)

func `div`*[T](a: SomeNumber, b: GVec3[T]): GVec3[T] =
  gvec3[T](b.x div a, b.y div a, b.z div a)

func `div`*[T](a, b: GVec3[T]): GVec3[T] =
  gvec3[T](a.x div b.x, a.y div b.y, a.z div b.z)

func `mod`*[T](a: GVec3[T], b: SomeNumber): GVec3[T] =
  gvec3[T](a.x mod b, a.y mod b, a.z mod b)

func `mod`*[T](a: SomeNumber, b: GVec3[T]): GVec3[T] =
  gvec3[T](b.x mod a, b.y mod a, b.z mod a)

func `mod`*[T](a, b: GVec3[T]): GVec3[T] =
  gvec3[T](a.x mod b.x, a.y mod b.y, a.z mod b.z)

func `+=`*[T](a: var GVec3[T], b: GVec3[T]) =
  a = a + b

func `-=`*[T](a: var GVec3[T], b: GVec3[T]) =
  a = a - b

func `*=`*[T](a: var GVec3[T], b: SomeNumber) =
  a = a * b

func `*=`*[T](a: var GVec3[T], b: GVec3[T]) =
  a = a * b

func `/=`*[T](a: var GVec3[T], b: SomeNumber) =
  a = a / b

func `/=`*[T](a: var GVec3[T], b: GVec3[T]) =
  a = a / b

func `div=`*[T](a: var GVec3[T], b: SomeNumber) =
  a = a div b

func `div=`*[T](a: var GVec3[T], b: GVec3[T]) =
  a = a div b

func `mod=`*[T](a: var GVec3[T], b: SomeNumber) =
  a = a mod b

func `mod=`*[T](a: var GVec3[T], b: GVec3[T]) =
  a = a mod b

# String functions for GVec3

func `$`*(self: BVec3): string =
  &"bvec3({self.x}, {self.y}, {self.z})"

func `$`*(self: IVec3): string =
  &"ivec3({self.x}, {self.y}, {self.z})"

func `$`*(self: UVec3): string =
  &"uvec3({self.x}, {self.y}, {self.z})"

func `$`*(self: Vec3): string =
  &"vec3({self.x}, {self.y}, {self.z})"

func `$`*(self: DVec3): string =
  &"dvec3({self.x}, {self.y}, {self.z})"

# Constructors for GVec4

func gvec4*[T](x, y, z, w: T): GVec4[T] = GVec4[T](x: x, y: y, z: z, w: w)
func bvec4*(x, y, z, w: bool): BVec4 = gvec4(x, y, z, w)
func ivec4*(x, y, z, w: int32): IVec4 = gvec4(x, y, z, w)
func uvec4*(x, y, z, w: uint32): UVec4 = gvec4(x, y, z, w)
func vec4*(x, y, z, w: float32): Vec4 = gvec4(x, y, z, w)
func dvec4*(x, y, z, w: float64): DVec4 = gvec4(x, y, z, w)

func gvec4*[T](x: T): GVec4[T] = gvec4(x, x, x, x)
func bvec4*(x: bool): BVec4 = gvec4(x)
func ivec4*(x: int32): IVec4 = gvec4(x)
func uvec4*(x: uint32): UVec4 = gvec4(x)
func vec4*(x: float32): Vec4 = gvec4(x)
func dvec4*(x: float64): DVec4 = gvec4(x)

func gvec4*[T](): GVec4[T] = gvec4(T.default, T.default, T.default, T.default)
func bvec4*(): BVec4 = gvec4[bool]()
func ivec4*(): IVec4 = gvec4[int32]()
func uvec4*(): UVec4 = gvec4[uint32]()
func vec4*(): Vec4 = gvec4[float32]()
func dvec4*(): DVec4 = gvec4[float64]()

# Operators for GVec4

func `==`*[T](a, b: GVec4[T]): bool =
  a.x == b.x and a.y == b.y and a.z == b.z and a.w == b.w

func `!=`*[T](a, b: GVec4[T]): bool =
  not (a == b)

func `+`*[T](a, b: GVec4[T]): GVec4[T] =
  gvec4[T](a.x + b.x, a.y + b.y, a.z + b.z, a.w + b.w)

func `-`*[T](a: GVec4[T]): GVec4[T] =
  gvec4[T](-a.x, -a.y, -a.z, -a.w)

func `-`*[T](a, b: GVec4[T]): GVec4[T] =
  gvec4[T](a.x - b.x, a.y - b.y, a.z - b.z, a.w - b.w)

func `*`*[T](a: GVec4[T], b: SomeNumber): GVec4[T] =
  gvec4[T](a.x * b, a.y * b, a.z * b, a.w * b)

func `*`*[T](a: SomeNumber, b: GVec4[T]): GVec4[T] =
  gvec4[T](b.x * a, b.y * a, b.z * a, b.w * a)

func `*`*[T](a, b: GVec4[T]): GVec4[T] =
  gvec4[T](a.x * b.x, a.y * b.y, a.z * b.z, a.w * b.w)

func `/`*[T](a: GVec4[T], b: SomeNumber): GVec4[T] =
  gvec4[T](a.x / b, a.y / b, a.z / b, a.w / b)

func `/`*[T](a: SomeNumber, b: GVec4[T]): GVec4[T] =
  gvec4[T](b.x / a, b.y / a, b.z / a, b.w / a)

func `/`*[T](a, b: GVec4[T]): GVec4[T] =
  gvec4[T](a.x / b.x, a.y / b.y, a.z / b.z, a.w / b.w)

func `div`*[T](a: GVec4[T], b: SomeNumber): GVec4[T] =
  gvec4[T](a.x div b, a.y div b, a.z div b, a.w div b)

func `div`*[T](a: SomeNumber, b: GVec4[T]): GVec4[T] =
  gvec4[T](b.x div a, b.y div a, b.z div a, b.w div a)

func `div`*[T](a, b: GVec4[T]): GVec4[T] =
  gvec4[T](a.x div b.x, a.y div b.y, a.z div b.z, a.w div b.w)

func `mod`*[T](a: GVec4[T], b: SomeNumber): GVec4[T] =
  gvec4[T](a.x mod b, a.y mod b, a.z mod b, a.w mod b)

func `mod`*[T](a: SomeNumber, b: GVec4[T]): GVec4[T] =
  gvec4[T](b.x mod a, b.y mod a, b.z mod a, b.w mod a)

func `mod`*[T](a, b: GVec4[T]): GVec4[T] =
  gvec4[T](a.x mod b.x, a.y mod b.y, a.z mod b.z, a.w mod b.w)

func `+=`*[T](a: var GVec4[T], b: GVec4[T]) =
  a = a + b

func `-=`*[T](a: var GVec4[T], b: GVec4[T]) =
  a = a - b

func `*=`*[T](a: var GVec4[T], b: SomeNumber) =
  a = a * b

func `*=`*[T](a: var GVec4[T], b: GVec4[T]) =
  a = a * b

func `/=`*[T](a: var GVec4[T], b: SomeNumber) =
  a = a / b

func `/=`*[T](a: var GVec4[T], b: GVec4[T]) =
  a = a / b

func `div=`*[T](a: var GVec4[T], b: SomeNumber) =
  a = a div b

func `div=`*[T](a: var GVec4[T], b: GVec4[T]) =
  a = a div b

func `mod=`*[T](a: var GVec4[T], b: SomeNumber) =
  a = a mod b

func `mod=`*[T](a: var GVec4[T], b: GVec4[T]) =
  a = a mod b

# String functions for GVec4

func `$`*(self: BVec4): string =
  &"bvec4({self.x}, {self.y}, {self.z}, {self.w})"

func `$`*(self: IVec4): string =
  &"ivec4({self.x}, {self.y}, {self.z}, {self.w})"

func `$`*(self: UVec4): string =
  &"uvec4({self.x}, {self.y}, {self.z}, {self.w})"

func `$`*(self: Vec4): string =
  &"vec4({self.x}, {self.y}, {self.z}, {self.w})"

func `$`*(self: DVec4): string =
  &"dvec4({self.x}, {self.y}, {self.z}, {self.w})"
