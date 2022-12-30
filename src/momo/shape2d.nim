from strformat import `&`
from sequtils import toSeq
import private/common, vector
export vector

type
  GCirc2*[T: SomeNumber] = object
    position*: GVec2[T]
    radius*: T
  ICirc2* = GCirc2[int32]
  UCirc2* = GCirc2[uint32]
  Circ2* = GCirc2[float32]
  DCirc2* = GCirc2[float64]

  GRect2*[T: SomeNumber] = object
    position*: GVec2[T]
    size*: GVec2[T]
  IRect2* = GRect2[int32]
  URect2* = GRect2[uint32]
  Rect2* = GRect2[float32]
  DRect2* = GRect2[float64]

  GLine2*[T: SomeNumber] = object
    a*: GVec2[T]
    b*: GVec2[T]
  ILine2* = GLine2[int32]
  ULine2* = GLine2[uint32]
  Line2* = GLine2[float32]
  DLine2* = GLine2[float64]

  GPoly2*[T: SomeNumber] = ref object
    position*: GVec2[T]
    points*: seq[GVec2[T]]
  IPoly2* = GPoly2[int32]
  UPoly2* = GPoly2[uint32]
  Poly2* = GPoly2[float32]
  DPoly2* = GPoly2[float64]

  SomeShape2*[T: SomeNumber] = GCirc2[T] | GRect2[T] | GLine2[T] | GPoly2[T]

# Helper Templates

template genGCirc2Con[T: SomeNumber](name: untyped) =
  func name*(x, y, radius: T): GCirc2[T] =
    GCirc2[T](position: gvec2[T](x, y), radius: radius)

  func name*(position: GVec2[T], radius: T): GCirc2[T] =
    GCirc2[T](position: position, radius: radius)

  func name*(): GCirc2[T] =
    GCirc2[T]()

template genGRect2Con[T: SomeNumber](name: untyped) =
  func name*(x, y, width, height: T): GRect2[T] =
    GRect2[T](position: gvec2[T](x, y), size: gvec2[T](width, height))

  func name*(position: GVec2[T], size: GVec2[T]): GRect2[T] =
    GRect2[T](position: position, size: size)

  func name*(): GRect2[T] =
    GRect2[T]()

template genGLine2Con[T: SomeNumber](name: untyped) =
  func name*(x1, y1, x2, y2: T): GLine2[T] =
    GLine2[T](a: gvec2[T](x1, y1), b: gvec2[T](x2, y2))

  func name*(a: GVec2[T], b: GVec2[T]): GLine2[T] =
    GLine2[T](a: a, b: b)

  func name*(): GLine2[T] =
    GLine2[T]()

template genGPoly2Con[T: SomeNumber](name: untyped) =
  func name*(x, y: T, points: varargs[GVec2[T]]): GPoly2[T] =
    GPoly2[T](position: gvec2[T](x, y), points: points.toSeq)

  func name*(position: GVec2[T], points: varargs[GVec2[T]]): GPoly2[T] =
    GPoly2[T](position: position, points: points.toSeq)

  func name*(): GPoly2[T] =
    GPoly2[T]()

template genOp(op: untyped) =
  func op*[T: SomeNumber](a, b: GCirc2[T]): GCirc2[T] =
    GCirc2[T](
      position: op(a.position, b.position),
      radius: op(a.radius, b.radius)
    )

  func op*[T, V: SomeNumber](a: GCirc2[T], b: V): GCirc2[T] =
    GCirc2[T](position: op(a.position, b), radius: op(a.radius.V, b).T)

  func op*[T, V: SomeNumber](b: V, a: GCirc2[T]): GCirc2[T] =
    GCirc2[T](position: op(a.position, b), radius: op(a.radius.V, b).T)

  func op*[T: SomeNumber](a, b: GRect2[T]): GRect2[T] =
    GRect2[T](
      position: op(a.position, b.position),
      size: op(a.size, b.size)
    )

  func op*[T, V: SomeNumber](a: GRect2[T], b: V): GRect2[T] =
    GRect2[T](position: op(a.position, b), size: op(a.size, b))

  func op*[T, V: SomeNumber](b: V, a: GRect2[T]): GRect2[T] =
    GRect2[T](position: op(a.position, b), size: op(a.size, b))

  func op*[T: SomeNumber](a, b: GLine2[T]): GLine2[T] =
    GLine2[T](a: op(a.a, b.a), b: op(a.b, b.b))

  func op*[T, V: SomeNumber](a: GLine2[T], b: V): GLine2[T] =
    GLine2[T](a: op(a.a, b), b: op(a.b, b))

  func op*[T, V: SomeNumber](b: V, a: GLine2[T]): GLine2[T] =
    GLine2[T](a: op(a.a, b), b: op(a.b, b))

template genEqOp(op: untyped) =
  func op*[T: SomeNumber](a: var GCirc2[T], b: GCirc2[T]) =
    op(a.position, b.position)
    op(a.radius, b.radius)

  func op*[T, V: SomeNumber](a: var GCirc2[T], b: V) =
    op(a.position, b)
    a.radius = op(a.radius.V, b).T

  func op*[T: SomeNumber](a: var GRect2[T], b: GRect2[T]) =
    op(a.position, b.position)
    op(a.size, b.size)

  func op*[T, V: SomeNumber](a: var GRect2[T], b: V) =
    op(a.position, b)
    op(a.size, b)

  func op*[T: SomeNumber](a: var GLine2[T], b: GLine2[T]) =
    op(a.a, b.a)
    op(a.b, b.b)

  func op*[T, V: SomeNumber](a: var GLine2[T], b: V) =
    op(a.a, b)
    op(a.b, b)

# Constructors and Operators

func gcirc2*[T: SomeNumber](x, y, radius: T): GCirc2[T] =
  GCirc2[T](position: gvec2[T](x, y), radius: radius)

func gcirc2*[T: SomeNumber](position: GVec2[T], radius: T): GCirc2[T] =
  GCirc2[T](position: position, radius: radius)

func gcirc2*[T: SomeNumber](): GCirc2[T] =
  GCirc2[T]()

func grect2*[T: SomeNumber](x, y, width, height: T): GRect2[T] =
  GRect2[T](position: gvec2[T](x, y), size: gvec2[T](width, height))

func grect2*[T: SomeNumber](position, size: GVec2[T]): GRect2[T] =
  GRect2[T](position: position, size: size)

func grect2*[T: SomeNumber](): GRect2[T] =
  GRect2[T]()

func gline2*[T: SomeNumber](x1, y1, x2, y2: T): GLine2[T] =
  GLine2[T](a: gvec2[T](x1, y1), b: gvec2[T](x2, y2))

func gline2*[T: SomeNumber](a, b: GVec2[T]): GLine2[T] =
  GLine2[T](a: a, b: b)

func gline2*[T: SomeNumber](): GLine2[T] =
  GLine2[T]()

func newGPoly2*[T](x, y: T, points: varargs[GVec2[T]]): GPoly2[T] =
  GPoly2[T](position: gvec2[T](x, y), points: points.toSeq)

func newGPoly2*[T](position: GVec2[T], points: varargs[GVec2[T]]): GPoly2[T] =
  GPoly2[T](position: position, points: points.toSeq)

func newGPoly2*[T](): GPoly2[T] =
  GPoly2[T]()

genGCirc2Con[int32](icirc2)
genGCirc2Con[uint32](ucirc2)
genGCirc2Con[float32](circ2)
genGCirc2Con[float64](dcirc2)

genGRect2Con[int32](irect2)
genGRect2Con[uint32](urect2)
genGRect2Con[float32](rect2)
genGRect2Con[float64](drect2)

genGLine2Con[int32](iline2)
genGLine2Con[uint32](uline2)
genGLine2Con[float32](line2)
genGLine2Con[float64](dline2)

genGPoly2Con[int32](newIPoly2)
genGPoly2Con[uint32](newUPoly2)
genGPoly2Con[float32](newPoly2)
genGPoly2Con[float64](newDPoly2)

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

# Functions

func `==`*[T: SomeNumber](a, b: GCirc2[T]): bool =
  a.position == b.position and a.radius == b.radius

func `==`*[T: SomeNumber](a, b: GRect2[T]): bool =
  a.position == b.position and a.size == b.size

func `==`*[T: SomeNumber](a, b: GLine2[T]): bool =
  a.a == b.a and a.b == b.b

func `==`*[T: SomeNumber](a, b: GPoly2[T]): bool =
  a.position == b.position and a.points == b.points

func `!=`*[T: SomeNumber](a, b: GCirc2[T]): bool =
  a.position != b.position or a.radius != b.radius

func `!=`*[T: SomeNumber](a, b: GRect2[T]): bool =
  a.position != b.position or a.size != b.size

func `!=`*[T: SomeNumber](a, b: GLine2[T]): bool =
  a.a != b.a or a.b != b.b

func `!=`*[T: SomeNumber](a, b: GPoly2[T]): bool =
  a.position != b.position or a.points != b.points

func `$`*[T: SomeNumber](self: GCirc2[T]): string =
  &"({self.position}, {self.radius})"

func `$`*[T: SomeNumber](self: GRect2[T]): string =
  &"({self.position}, {self.size})"

func `$`*[T: SomeNumber](self: GLine2[T]): string =
  &"({self.a}, {self.b})"

func `$`*[T: SomeNumber](self: GPoly2[T]): string =
  &"({self.position}, {self.points})"
