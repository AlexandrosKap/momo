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

# Constructors and operators

func gvec2*[T: SomeNumber](x, y: T): GVec2[T] =
  GVec2[T](x: x, y: y)

func gvec2*[T: SomeNumber](x: T): GVec2[T] =
  GVec2[T](x: x, y: x)

func gvec2*[T: SomeNumber](): GVec2[T] =
  GVec2[T]()

func gvec3*[T: SomeNumber](x, y, z: T): GVec3[T] =
  GVec3[T](x: x, y: y, z: z)

func gvec3*[T: SomeNumber](x: T): GVec3[T] =
  GVec3[T](x: x, y: x, z: x)

func gvec3*[T: SomeNumber](): GVec3[T] =
  GVec3[T]()

func gvec4*[T: SomeNumber](x, y, z, w: T): GVec4[T] =
  GVec4[T](x: x, y: y, z: z, w: w)

func gvec4*[T: SomeNumber](x: T): GVec4[T] =
  GVec4[T](x: x, y: x, z: x, w: x)

func gvec4*[T: SomeNumber](): GVec4[T] =
  GVec4[T]()

template genCon[T: SomeNumber](name: untyped) =
  func `name 2`*(x, y: T): GVec2[T] =
    gvec2[T](x, y)

  func `name 2`*(x: T): GVec2[T] =
    gvec2[T](x)

  func `name 2`*(): GVec2[T] =
    gvec2[T]()

  func `name 3`*(x, y, z: T): GVec3[T] =
    gvec3[T](x, y, z)

  func `name 3`*(x: T): GVec3[T] =
    gvec3[T](x)

  func `name 3`*(): GVec3[T] =
    gvec3[T]()

  func `name 4`*(x, y, z, w: T): GVec4[T] =
    gvec4[T](x, y, z, w)

  func `name 4`*(x: T): GVec4[T] =
    gvec4[T](x)

  func `name 4`*(): GVec4[T] =
    gvec4[T]()

template genOp(op: untyped) =
  func op*[T: SomeNumber](a, b: GVec2[T]): GVec2[T] =
    gvec2[T](op(a.x, b.x), op(a.y, b.y))

  func op*[T, V: SomeNumber](a: GVec2[T], b: V): GVec2[T] =
    when V is T:
      gvec2[T](op(a.x, b), op(a.y, b))
    else:
      gvec2[T](op(a.x.V, b).T, op(a.y.V, b).T)

  func op*[T, V: SomeNumber](b: V, a: GVec2[T]): GVec2[T] =
    when V is T:
      gvec2[T](op(a.x, b), op(a.y, b))
    else:
      gvec2[T](op(a.x.V, b).T, op(a.y.V, b).T)

  func op*[T: SomeNumber](a, b: GVec3[T]): GVec3[T] =
    gvec3[T](op(a.x, b.x), op(a.y, b.y), op(a.z, b.z))

  func op*[T, V: SomeNumber](a: GVec3[T], b: V): GVec3[T] =
    when V is T:
      gvec3[T](op(a.x, b), op(a.y, b), op(a.z, b))
    else:
      gvec3[T](op(a.x.V, b).T, op(a.y.V, b).T, op(a.z.V, b).T)

  func op*[T, V: SomeNumber](b: V, a: GVec3[T]): GVec3[T] =
    when V is T:
      gvec3[T](op(a.x, b), op(a.y, b), op(a.z, b))
    else:
      gvec3[T](op(a.x.V, b).T, op(a.y.V, b).T, op(a.z.V, b).T)

  func op*[T: SomeNumber](a, b: GVec4[T]): GVec4[T] =
    gvec4[T](op(a.x, b.x), op(a.y, b.y), op(a.z, b.z), op(a.w, b.w))

  func op*[T, V: SomeNumber](a: GVec4[T], b: V): GVec4[T] =
    when V is T:
      gvec4[T](op(a.x, b), op(a.y, b), op(a.z, b), op(a.w, b))
    else:
      gvec4[T](op(a.x.V, b).T, op(a.y.V, b).T, op(a.z.V, b).T, op(a.w.V, b).T)

  func op*[T, V: SomeNumber](b: V, a: GVec4[T]): GVec4[T] =
    when V is T:
      gvec4[T](op(a.x, b), op(a.y, b), op(a.z, b), op(a.w, b))
    else:
      gvec4[T](op(a.x.V, b).T, op(a.y.V, b).T, op(a.z.V, b).T, op(a.w.V, b).T)

template genEqOp(op: untyped) =
  func op*[T: SomeNumber](a: var GVec2[T], b: GVec2[T]) =
    op(a.x, b.x)
    op(a.y, b.y)

  func op*[T, V: SomeNumber](a: var GVec2[T], b: V) =
    when V is T:
      op(a.x, b)
      op(a.y, b)
    else:
      a.x = op(a.x.V, b).T
      a.y = op(a.y.V, b).T

  func op*[T: SomeNumber](a: var GVec3[T], b: GVec3[T]) =
    op(a.x, b.x)
    op(a.y, b.y)
    op(a.z, b.z)

  func op*[T, V: SomeNumber](a: var GVec3[T], b: V) =
    when V is T:
      op(a.x, b)
      op(a.y, b)
      op(a.z, b)
    else:
      a.x = op(a.x.V, b).T
      a.y = op(a.y.V, b).T
      a.z = op(a.z.V, b).T

  func op*[T: SomeNumber](a: var GVec4[T], b: GVec4[T]) =
    op(a.x, b.x)
    op(a.y, b.y)
    op(a.z, b.z)
    op(a.w, b.w)

  func op*[T, V: SomeNumber](a: var GVec4[T], b: V) =
    when V is T:
      op(a.x, b)
      op(a.y, b)
      op(a.z, b)
    else:
      a.x = op(a.x.V, b).T
      a.y = op(a.y.V, b).T
      a.z = op(a.z.V, b).T
      a.w = op(a.w.V, b).T

template genBoolOp(op: untyped) =
  func op*[T: SomeNumber](a, b: GVec2[T]): bool =
    op(a.x, b.x) and op(a.y, b.y)

  func op*[T: SomeNumber](a, b: GVec3[T]): bool =
    op(a.x, b.x) and op(a.y, b.y) and op(a.z, b.z)

  func op*[T: SomeNumber](a, b: GVec4[T]): bool =
    op(a.x, b.x) and op(a.y, b.y) and op(a.z, b.z) and op(a.w, b.w)

genCon[int32](ivec)
genCon[uint32](uvec)
genCon[float32](vec)
genCon[float64](dvec)

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

genBoolOp(`==`)
genBoolOp(`!=`)

# Functions

func `-`*[T: SomeSignedInt | SomeFloat](a: GVec2[T]): GVec2[T] =
  GVec2[T](x: -a.x, y: -a.y)

func `-`*[T: SomeSignedInt | SomeFloat](a: GVec3[T]): GVec3[T] =
  GVec3[T](x: -a.x, y: -a.y, z: -a.z)

func `-`*[T: SomeSignedInt | SomeFloat](a: GVec4[T]): GVec4[T] =
  GVec4[T](x: -a.x, y: -a.y, z: -a.z, w: -a.w)

func `$`*[T: SomeNumber](self: GVec2[T]): string =
  &"({self.x}, {self.y})"

func `$`*[T: SomeNumber](self: GVec3[T]): string =
  &"({self.x}, {self.y}, {self.z})"

func `$`*[T: SomeNumber](self: GVec4[T]): string =
  &"({self.x}, {self.y}, {self.z}, {self.w})"

const zero2* = vec2()
const one2* = vec2(1)
const left2* = vec2(-1, 0)
const right2* = vec2(1, 0)
const up2* = vec2(0, -1)
const down2* = vec2(0, 1)
