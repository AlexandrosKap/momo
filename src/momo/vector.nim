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

# Helper templates for GVec

template genCon(name, t: untyped) =
  func `name 2`*(x, y: t): GVec2[t] =
    GVec2[t](x: x, y: y)

  func `name 2`*(x: t): GVec2[t] =
    GVec2[t](x: x, y: x)

  func `name 2`*(): GVec2[t] =
    GVec2[t](x: t.default, y: t.default)

  func `name 3`*(x, y, z: t): GVec3[t] =
    GVec3[t](x: x, y: y, z: z)

  func `name 3`*(x: t): GVec3[t] =
    GVec3[t](x: x, y: x, z: x)

  func `name 3`*(): GVec3[t] =
    GVec3[t](x: t.default, y: t.default, z: t.default)

  func `name 4`*(x, y, z, w: t): GVec4[t] =
    GVec4[t](x: x, y: y, z: z, w: w)

  func `name 4`*(x: t): GVec4[t] =
    GVec4[t](x: x, y: x, z: x, w: x)

  func `name 4`*(): GVec4[t] =
    GVec4[t](x: t.default, y: t.default, z: t.default, w: t.default)

template genOp(op: untyped, isBool: static bool = false) =
  when isBool:
    func op*[T: SomeNumber](a, b: GVec2[T]): bool =
      op(a.x, b.x) and op(a.y, b.y)

    func op*[T: SomeNumber](a, b: GVec3[T]): bool =
      op(a.x, b.x) and op(a.y, b.y) and op(a.z, b.z)

    func op*[T: SomeNumber](a, b: GVec4[T]): bool =
      op(a.x, b.x) and op(a.y, b.y) and op(a.z, b.z) and op(a.w, b.w)
  else:
    func op*[T: SomeNumber](a, b: GVec2[T]): GVec2[T] =
      GVec2[T](x: op(a.x, b.x), y: op(a.y, b.y))

    func op*[T: SomeNumber](a: GVec2[T], b: T): GVec2[T] =
      GVec2[T](x: op(a.x, b), y: op(a.y, b))

    func op*[T: SomeNumber](a, b: GVec3[T]): GVec3[T] =
      GVec3[T](x: op(a.x, b.x), y: op(a.y, b.y), z: op(a.z, b.z))

    func op*[T: SomeNumber](a: GVec3[T], b: T): GVec3[T] =
      GVec3[T](x: op(a.x, b), y: op(a.y, b), z: op(a.z, b))

    func op*[T: SomeNumber](a, b: GVec4[T]): GVec4[T] =
      GVec4[T](x: op(a.x, b.x), y: op(a.y, b.y), z: op(a.z, b.z), w: op(a.w, b.w))

    func op*[T: SomeNumber](a: GVec4[T], b: T): GVec4[T] =
      GVec4[T](x: op(a.x, b), y: op(a.y, b), z: op(a.z, b), w: op(a.w, b))

template genEqOp(op: untyped) =
  func op*[T: SomeNumber](a: var GVec2[T], b: GVec2[T]) =
    op(a.x, b.x)
    op(a.y, b.y)

  func op*[T: SomeNumber](a: var GVec2[T], b: T) =
    op(a.x, b)
    op(a.y, b)

  func op*[T: SomeNumber](a: var GVec3[T], b: GVec3[T]) =
    op(a.x, b.x)
    op(a.y, b.y)
    op(a.z, b.z)

  func op*[T: SomeNumber](a: var GVec3[T], b: T) =
    op(a.x, b)
    op(a.y, b)
    op(a.z, b)

  func op*[T: SomeNumber](a: var GVec4[T], b: GVec4[T]) =
    op(a.x, b.x)
    op(a.y, b.y)
    op(a.z, b.z)
    op(a.w, b.w)

  func op*[T: SomeNumber](a: var GVec4[T], b: T) =
    op(a.x, b)
    op(a.y, b)
    op(a.z, b)
    op(a.w, b)

genCon(ivec, int32)
genCon(uvec, uint32)
genCon(vec, float32)
genCon(dvec, float64)

genOp(`==`, true)
genOp(`!=`, true)
genOp(`+`)
genOp(`-`)
genOp(`*`)
genOp(`/`)
genOp(`div`)
genOp(`mod`)

genEqOp(`+=`)
genEqOp(`-=`)
genEqOp(`*=`)
genEqOp(`/=`)
genEqOp(`div=`)
genEqOp(`mod=`)

# Functions for GVec

func `-`*[T: SomeSignedInt | SomeFloat](a: GVec2[T]): GVec2[T] =
  GVec2[T](x: -a.x, y: -a.y)

func `-`*[T: SomeSignedInt | SomeFloat](a: GVec3[T]): GVec3[T] =
  GVec3[T](x: -a.x, y: -a.y, z: -a.z)

func `-`*[T: SomeSignedInt | SomeFloat](a: GVec4[T]): GVec4[T] =
  GVec4[T](x: -a.x, y: -a.y, z: -a.z, w: -a.w)

func `$`*[T: SomeNumber](self: GVec2[T]): string =
  &"vec({self.x}, {self.y})"

func `$`*[T: SomeNumber](self: GVec3[T]): string =
  &"vec({self.x}, {self.y}, {self.z})"

func `$`*[T: SomeNumber](self: GVec4[T]): string =
  &"vec({self.x}, {self.y}, {self.z}, {self.w})"

const zero2* = vec2()
const one2* = vec2(1)
const left2* = vec2(-1, 0)
const right2* = vec2(1, 0)
const up2* = vec2(0, -1)
const down2* = vec2(0, 1)
