from strformat import `&`
import common

type
  GVec2*[T: SomeNumber] = object
    x*, y*: T
  IVec2* = GVec2[int32]
  UVec2* = GVec2[uint32]
  Vec2* = GVec2[float32]
  DVec2* = GVec2[float64]

  GVec3*[T: SomeNumber] = object
    x*, y*, z*: T
  IVec3* = GVec3[int32]
  UVec3* = GVec3[uint32]
  Vec3* = GVec3[float32]
  DVec3* = GVec3[float64]

  GVec4*[T: SomeNumber] = object
    x*, y*, z*, w*: T
  IVec4* = GVec4[int32]
  UVec4* = GVec4[uint32]
  Vec4* = GVec4[float32]
  DVec4* = GVec4[float64]

  SomeVec*[T: SomeNumber] = GVec2[T] | GVec3[T] | GVec4[T]

# Constructors for GVec2

func gvec2*[T: SomeNumber](x, y: T): GVec2[T] =
  GVec2[T](x: x, y: y)

func ivec2*(x, y: int32): IVec2 =
  gvec2[int32](x, y)

func uvec2*(x, y: uint32): UVec2 =
  gvec2[uint32](x, y)

func vec2*(x, y: float32): Vec2 =
  gvec2[float32](x, y)

func dvec2*(x, y: float64): DVec2 =
  gvec2[float64](x, y)

func gvec2*[T: SomeNumber](x: T): GVec2[T] =
  gvec2[T](x, x)

func ivec2*(x: int32): IVec2 =
  gvec2[int32](x)

func uvec2*(x: uint32): UVec2 =
  gvec2[uint32](x)

func vec2*(x: float32): Vec2 =
  gvec2[float32](x)

func dvec2*(x: float64): DVec2 =
  gvec2[float64](x)

func gvec2*[T: SomeNumber](): GVec2[T] =
  gvec2[T](T.default, T.default)

func ivec2*(): IVec2 =
  gvec2[int32]()

func uvec2*(): UVec2 =
  gvec2[uint32]()

func vec2*(): Vec2 =
  gvec2[float32]()

func dvec2*(): DVec2 =
  gvec2[float64]()

# Operators for GVec2

func `==`*[T: SomeNumber](a, b: GVec2[T]): bool =
  a.x == b.x and a.y == b.y

func `!=`*[T: SomeNumber](a, b: GVec2[T]): bool =
  not (a == b)

func `+`*[T: SomeNumber](a, b: GVec2[T]): GVec2[T] =
  gvec2[T](a.x + b.x, a.y + b.y)

func `-`*[T: SomeSignedInt | SomeFloat](a: GVec2[T]): GVec2[T] =
  gvec2[T](-a.x, -a.y)

func `-`*[T: SomeNumber](a, b: GVec2[T]): GVec2[T] =
  gvec2[T](a.x - b.x, a.y - b.y)

func `*`*[T: SomeNumber](a, b: GVec2[T]): GVec2[T] =
  gvec2[T](a.x * b.x, a.y * b.y)

func `/`*[T: SomeNumber](a, b: GVec2[T]): GVec2[T] =
  gvec2[T](a.x / b.x, a.y / b.y)

func `div`*[T: SomeNumber](a, b: GVec2[T]): GVec2[T] =
  gvec2[T](a.x div b.x, a.y div b.y)

func `mod`*[T: SomeNumber](a, b: GVec2[T]): GVec2[T] =
  gvec2[T](a.x mod b.x, a.y mod b.y)

func `+=`*[T: SomeNumber](a: var GVec2[T], b: GVec2[T]) =
  a = a + b

func `-=`*[T: SomeNumber](a: var GVec2[T], b: GVec2[T]) =
  a = a - b

func `*=`*[T: SomeNumber](a: var GVec2[T], b: GVec2[T]) =
  a = a * b

func `/=`*[T: SomeNumber](a: var GVec2[T], b: GVec2[T]) =
  a = a / b

func `div=`*[T: SomeNumber](a: var GVec2[T], b: GVec2[T]) =
  a = a div b

func `mod=`*[T: SomeNumber](a: var GVec2[T], b: GVec2[T]) =
  a = a mod b

func `*`*[T, V: SomeNumber](a: GVec2[T], b: V): GVec2[T] =
  when T is V:
    gvec2[T](a.x * b, a.y * b)
  else:
    gvec2[T]((a.x.V * b).T, (a.y.V * b).T)

func `*`*[T, V: SomeNumber](a: V, b: GVec2[T]): GVec2[T] =
  b * a

func `/`*[T, V: SomeNumber](a: GVec2[T], b: V): GVec2[T] =
  when T is V:
    gvec2[T](a.x / b, a.y / b)
  else:
    gvec2[T]((a.x.V / b).T, (a.y.V / b).T)

func `/`*[T, V: SomeNumber](a: V, b: GVec2[T]): GVec2[T] =
  b / a

func `*=`*[T, V: SomeNumber](a: var GVec2[T], b: V) =
  a = a * b

func `/=`*[T, V: SomeNumber](a: var GVec2[T], b: V) =
  a = a / b

func `$`*[T: SomeNumber](self: GVec2[T]): string =
  &"vec({self.x}, {self.y})"

# Constructors for GVec3

func gvec3*[T: SomeNumber](x, y, z: T): GVec3[T] =
  GVec3[T](x: x, y: y, z: z)

func ivec3*(x, y, z: int32): IVec3 =
  gvec3[int32](x, y, z)

func uvec3*(x, y, z: uint32): UVec3 =
  gvec3[uint32](x, y, z)

func vec3*(x, y, z: float32): Vec3 =
  gvec3[float32](x, y, z)

func dvec3*(x, y, z: float64): DVec3 =
  gvec3[float64](x, y, z)

func gvec3*[T: SomeNumber](x: T): GVec3[T] =
  gvec3[T](x, x, x)

func ivec3*(x: int32): IVec3 =
  gvec3[int32](x)

func uvec3*(x: uint32): UVec3 =
  gvec3[uint32](x)

func vec3*(x: float32): Vec3 =
  gvec3[float32](x)

func dvec3*(x: float64): DVec3 =
  gvec3[float64](x)

func gvec3*[T: SomeNumber](): GVec3[T] =
  gvec3[T](T.default, T.default, T.default)

func ivec3*(): IVec3 =
  gvec3[int32]()

func uvec3*(): UVec3 =
  gvec3[uint32]()

func vec3*(): Vec3 =
  gvec3[float32]()

func dvec3*(): DVec3 =
  gvec3[float64]()

# Operators for GVec3

func `==`*[T: SomeNumber](a, b: GVec3[T]): bool =
  a.x == b.x and a.y == b.y and a.z == b.z

func `!=`*[T: SomeNumber](a, b: GVec3[T]): bool =
  not (a == b)

func `+`*[T: SomeNumber](a, b: GVec3[T]): GVec3[T] =
  gvec3[T](a.x + b.x, a.y + b.y, a.z + b.z)

func `-`*[T: SomeSignedInt | SomeFloat](a: GVec3[T]): GVec3[T] =
  gvec3[T](-a.x, -a.y, -a.z)

func `-`*[T: SomeNumber](a, b: GVec3[T]): GVec3[T] =
  gvec3[T](a.x - b.x, a.y - b.y, a.z - b.z)

func `*`*[T: SomeNumber](a, b: GVec3[T]): GVec3[T] =
  gvec3[T](a.x * b.x, a.y * b.y, a.z * b.z)

func `/`*[T: SomeNumber](a, b: GVec3[T]): GVec3[T] =
  gvec3[T](a.x / b.x, a.y / b.y, a.z / b.z)

func `div`*[T: SomeNumber](a, b: GVec3[T]): GVec3[T] =
  gvec3[T](a.x div b.x, a.y div b.y, a.z div b.z)

func `mod`*[T: SomeNumber](a, b: GVec3[T]): GVec3[T] =
  gvec3[T](a.x mod b.x, a.y mod b.y, a.z mod b.z)

func `+=`*[T: SomeNumber](a: var GVec3[T], b: GVec3[T]) =
  a = a + b

func `-=`*[T: SomeNumber](a: var GVec3[T], b: GVec3[T]) =
  a = a - b

func `*=`*[T: SomeNumber](a: var GVec3[T], b: GVec3[T]) =
  a = a * b

func `/=`*[T: SomeNumber](a: var GVec3[T], b: GVec3[T]) =
  a = a / b

func `div=`*[T: SomeNumber](a: var GVec3[T], b: GVec3[T]) =
  a = a div b

func `mod=`*[T: SomeNumber](a: var GVec3[T], b: GVec3[T]) =
  a = a mod b

func `*`*[T, V: SomeNumber](a: GVec3[T], b: V): GVec3[T] =
  when T is V:
    gvec3[T](a.x * b, a.y * b, a.z * b)
  else:
    gvec3[T]((a.x.V * b).T, (a.y.V * b).T, (a.z.V * b).T)

func `*`*[T, V: SomeNumber](a: V, b: GVec3[T]): GVec3[T] =
  b * a

func `/`*[T, V: SomeNumber](a: GVec3[T], b: V): GVec3[T] =
  when T is V:
    gvec3[T](a.x / b, a.y / b, a.z / b)
  else:
    gvec3[T]((a.x.V / b).T, (a.y.V / b).T, (a.z.V / b).T)

func `/`*[T, V: SomeNumber](a: V, b: GVec3[T]): GVec3[T] =
  b / a

func `*=`*[T, V: SomeNumber](a: var GVec3[T], b: V) =
  a = a * b

func `/=`*[T, V: SomeNumber](a: var GVec3[T], b: V) =
  a = a / b

func `$`*[T: SomeNumber](self: GVec3[T]): string =
  &"vec({self.x}, {self.y}, {self.z})"

# Constructors for GVec4

func gvec4*[T: SomeNumber](x, y, z, w: T): GVec4[T] =
  GVec4[T](x: x, y: y, z: z, w: w)

func ivec4*(x, y, z, w: int32): IVec4 =
  gvec4[int32](x, y, z, w)

func uvec4*(x, y, z, w: uint32): UVec4 =
  gvec4[uint32](x, y, z, w)

func vec4*(x, y, z, w: float32): Vec4 =
  gvec4[float32](x, y, z, w)

func dvec4*(x, y, z, w: float64): DVec4 =
  gvec4[float64](x, y, z, w)

func gvec4*[T: SomeNumber](x: T): GVec4[T] =
  gvec4[T](x, x, x, x)

func ivec4*(x: int32): IVec4 =
  gvec4[int32](x)

func uvec4*(x: uint32): UVec4 =
  gvec4[uint32](x)

func vec4*(x: float32): Vec4 =
  gvec4[float32](x)

func dvec4*(x: float64): DVec4 =
  gvec4[float64](x)

func gvec4*[T: SomeNumber](): GVec4[T] =
  gvec4[T](T.default, T.default, T.default, T.default)

func ivec4*(): IVec4 =
  gvec4[int32]()

func uvec4*(): UVec4 =
  gvec4[uint32]()

func vec4*(): Vec4 =
  gvec4[float32]()

func dvec4*(): DVec4 =
  gvec4[float64]()

# Operators for GVec4

func `==`*[T: SomeNumber](a, b: GVec4[T]): bool =
  a.x == b.x and a.y == b.y and a.z == b.z and a.w == b.w

func `!=`*[T: SomeNumber](a, b: GVec4[T]): bool =
  not (a == b)

func `+`*[T: SomeNumber](a, b: GVec4[T]): GVec4[T] =
  gvec4[T](a.x + b.x, a.y + b.y, a.z + b.z, a.w + b.w)

func `-`*[T: SomeSignedInt | SomeFloat](a: GVec4[T]): GVec4[T] =
  gvec4[T](-a.x, -a.y, -a.z, -a.w)

func `-`*[T: SomeNumber](a, b: GVec4[T]): GVec4[T] =
  gvec4[T](a.x - b.x, a.y - b.y, a.z - b.z, a.w - b.w)

func `*`*[T: SomeNumber](a, b: GVec4[T]): GVec4[T] =
  gvec4[T](a.x * b.x, a.y * b.y, a.z * b.z, a.w * b.w)

func `/`*[T: SomeNumber](a, b: GVec4[T]): GVec4[T] =
  gvec4[T](a.x / b.x, a.y / b.y, a.z / b.z, a.w / b.w)

func `div`*[T: SomeNumber](a, b: GVec4[T]): GVec4[T] =
  gvec4[T](a.x div b.x, a.y div b.y, a.z div b.z, a.w div b.w)

func `mod`*[T: SomeNumber](a, b: GVec4[T]): GVec4[T] =
  gvec4[T](a.x mod b.x, a.y mod b.y, a.z mod b.z, a.w mod b.w)

func `+=`*[T: SomeNumber](a: var GVec4[T], b: GVec4[T]) =
  a = a + b

func `-=`*[T: SomeNumber](a: var GVec4[T], b: GVec4[T]) =
  a = a - b

func `*=`*[T: SomeNumber](a: var GVec4[T], b: GVec4[T]) =
  a = a * b

func `/=`*[T: SomeNumber](a: var GVec4[T], b: GVec4[T]) =
  a = a / b

func `div=`*[T: SomeNumber](a: var GVec4[T], b: GVec4[T]) =
  a = a div b

func `mod=`*[T: SomeNumber](a: var GVec4[T], b: GVec4[T]) =
  a = a mod b

func `*`*[T, V: SomeNumber](a: GVec4[T], b: V): GVec4[T] =
  when T is V:
    gvec4[T](a.x * b, a.y * b, a.z * b, a.w * b)
  else:
    gvec4[T]((a.x.V * b).T, (a.y.V * b).T, (a.z.V * b).T, (a.w.V * b).T)

func `*`*[T, V: SomeNumber](a: V, b: GVec4[T]): GVec4[T] =
  b * a

func `/`*[T, V: SomeNumber](a: GVec4[T], b: V): GVec4[T] =
  when T is V:
    gvec4[T](a.x / b, a.y / b, a.z / b, a.w / b)
  else:
    gvec4[T]((a.x.V / b).T, (a.y.V / b).T, (a.z.V / b).T, (a.w.V / b).T)

func `/`*[T, V: SomeNumber](a: V, b: GVec4[T]): GVec4[T] =
  b / a

func `*=`*[T, V: SomeNumber](a: var GVec4[T], b: V) =
  a = a * b

func `/=`*[T, V: SomeNumber](a: var GVec4[T], b: V) =
  a = a / b

func `$`*[T: SomeNumber](self: GVec4[T]): string =
  &"vec({self.x}, {self.y}, {self.z}, {self.w})"

const zero2* = vec2()
const one2* = vec2(1)
const left2* = vec2(-1, 0)
const right2* = vec2(1, 0)
const up2* = vec2(0, -1)
const down2* = vec2(0, 1)
