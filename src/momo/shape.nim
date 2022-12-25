import vector

# TODO: WORKING ON IT UWU

type
  GCirc*[T: SomeNumber] = object
    position*: GVec2[T]
    radius*: T
  ICirc* = GCirc[int32]
  UCirc* = GCirc[uint32]
  Circ* = GCirc[float32]
  DCirc* = GCirc[float64]

  GRect*[T: SomeNumber] = object
    position*: GVec2[T]
    size*: GVec2[T]
  IRect* = GRect[int32]
  URect* = GRect[uint32]
  Rect* = GRect[float32]
  DRect* = GRect[float64]

  GLine*[T: SomeNumber] = object
    a*: GVec2[T]
    b*: GVec2[T]
  ILine* = GLine[int32]
  ULine* = GLine[uint32]
  Line* = GLine[float32]
  DLine* = GLine[float64]

  GPolygon*[T: SomeNumber] = seq[GVec2[T]]
  IPolygon* = GPolygon[int32]
  UPolygon* = GPolygon[uint32]
  Polygon* = GPolygon[float32]
  DPolygon* = GPolygon[float64]

  SomeShape*[T: SomeNumber] = GLine[T] | GCirc[T] | GRect[T] | GPolygon[T]

# Constructors and operators

func gcirc*[T: SomeNumber](x, y, radius: T): GCirc[T] =
  GCirc[T](position: gvec2[T](x, y), radius: radius)

func gcirc*[T: SomeNumber](position: GVec2[T], radius: T): GCirc[T] =
  GCirc[T](position: position, radius: radius)

func gcirc*[T: SomeNumber](): GCirc[T] =
  GCirc[T]()

func grect*[T: SomeNumber](x, y, width, height: T): GRect[T] =
  GRect[T](position: gvec2[T](x, y), size: gvec2[T](width, height))

func grect*[T: SomeNumber](position, size: GVec2[T]): GRect[T] =
  GRect[T](position: position, size: size)

func grect*[T: SomeNumber](): GRect[T] =
  GRect[T]()

func gline*[T: SomeNumber](x1, y1, x2, y2: T): GLine[T] =
  GLine[T](a: gvec2[T](x1, y1), b: gvec2[T](x2, y2))

func gline*[T: SomeNumber](a, b: GVec2[T]): GLine[T] =
  GLine[T](a: a, b: b)

func gline*[T: SomeNumber](): GLine[T] =
  GLine[T]()

template genGCircCon[T: SomeNumber](name: untyped) =
  func name*(x, y, radius: T): GCirc[T] =
    gcirc[T](gvec2[T](x, y), radius)

  func name*(position: GVec2[T], radius: T): GCirc[T] =
    gcirc[T](position, radius)

  func name*(): GCirc[T] =
    gcirc[T]()

template genGRectCon[T: SomeNumber](name: untyped) =
  func name*(x, y, width, height: T): GRect[T] =
    grect[T](gvec2[T](x, y), gvec2[T](width, height))

  func name*(position: GVec2[T], size: GVec2[T]): GRect[T] =
    grect[T](position, size)

  func name*(): GRect[T] =
    grect[T]()

template genGLineCon[T: SomeNumber](name: untyped) =
  func name*(x1, y1, x2, y2: T): GLine[T] =
    gline[T](gvec2[T](x1, y1), gvec2[T](x2, y2))

  func name*(a: GVec2[T], b: GVec2[T]): GLine[T] =
    gline[T](a, b)

  func name*(): GLine[T] =
    gline[T]()

template genOp(op: untyped) =
  func op*[T: SomeNumber](a, b: GCirc[T]): GCirc[T] =
    gcirc[T](op(a.position, b.position), op(a.radius, b.radius))

  func op*[T, V: SomeNumber](a: GCirc[T], b: V): GCirc[T] =
    when V is T:
      gcirc[T](op(a.position, b), op(a.radius, b))
    else:
      gcirc[T](op(a.position, b), op(a.radius.V, b).T)

  func op*[T, V: SomeNumber](b: V, a: GCirc[T]): GCirc[T] =
    when V is T:
      gcirc[T](op(a.position, b), op(a.radius, b))
    else:
      gcirc[T](op(a.position, b), op(a.radius.V, b).T)

  func op*[T: SomeNumber](a, b: GRect[T]): GRect[T] =
    grect[T](op(a.position, b.position), op(a.size, b.size))

  func op*[T, V: SomeNumber](a: GRect[T], b: V): GRect[T] =
    grect[T](op(a.position, b), op(a.size, b))

  func op*[T, V: SomeNumber](b: V, a: GRect[T]): GRect[T] =
    grect[T](op(a.position, b), op(a.size, b))

  func op*[T: SomeNumber](a, b: GLine[T]): GLine[T] =
    gline[T](op(a.a, b.a), op(a.b, b.b))

  func op*[T, V: SomeNumber](a: GLine[T], b: V): GLine[T] =
    gline[T](op(a.a, b), op(a.b, b))

  func op*[T, V: SomeNumber](b: V, a: GLine[T]): GLine[T] =
    gline[T](op(a.a, b), op(a.b, b))

template genEqOp(op: untyped) =
  func op*[T: SomeNumber](a: var GCirc[T], b: GCirc[T]) =
    op(a.position, b.position)
    op(a.radius, b.radius)

  func op*[T, V: SomeNumber](a: var GCirc[T], b: V) =
    when V is T:
      op(a.position, b)
      op(a.radius, b)
    else:
      op(a.position, b)
      a.radius = op(a.radius.V, b).T

  func op*[T: SomeNumber](a: var GRect[T], b: GRect[T]) =
    op(a.position, b.position)
    op(a.size, b.size)

  func op*[T, V: SomeNumber](a: var GRect[T], b: V) =
    op(a.position, b)
    op(a.size, b)

  func op*[T: SomeNumber](a: var GLine[T], b: GLine[T]) =
    op(a.a, b.a)
    op(a.b, b.b)

  func op*[T, V: SomeNumber](a: var GLine[T], b: V) =
    op(a.a, b)
    op(a.b, b)

template genBoolOp(op: untyped) =
  func op*[T: SomeNumber](a, b: GCirc[T]): bool =
    op(a.position, b.position) and op(a.radius, b.radius)

  func op*[T: SomeNumber](a, b: GRect[T]): bool =
    op(a.position, b.position) and op(a.size, b.size)

  func op*[T: SomeNumber](a, b: GLine[T]): bool =
    op(a.a, b.a) and op(a.b, b.b)

genGCircCon[int32](icirc)
genGCircCon[uint32](ucirc)
genGCircCon[float32](circ)
genGCircCon[float64](dcirc)

genGRectCon[int32](irect)
genGRectCon[uint32](urect)
genGRectCon[float32](rect)
genGRectCon[float64](drect)

genGLineCon[int32](iline)
genGLineCon[uint32](uline)
genGLineCon[float32](line)
genGLineCon[float64](dline)

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
