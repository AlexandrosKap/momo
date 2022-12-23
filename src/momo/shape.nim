import vector

# TODO: WORKING ON IT UWU

type
  GLine*[T: SomeNumber] = object
    a*: GVec2[T]
    b*: GVec2[T]
  Line* = GLine[float32]

  GCirc*[T: SomeNumber] = object
    position*: GVec2[T]
    radius*: T
  Circ* = GCirc[float32]

  GRect*[T: SomeNumber] = object
    position*: GVec2[T]
    size*: GVec2[T]
  Rect* = GRect[float32]

  GPolygon*[T: SomeNumber] = ref object
    position*: GVec2[T]
    points*: seq[GVec2[T]]
  Polygon* = GPolygon[float32]

  SomeShape*[T: SomeNumber] = GLine[T] | GCirc[T] | GRect[T] | GPolygon[T]

# Line stuff

func gline*[T: SomeNumber](a, b: GVec2[T]): GLine[T] =
  GLine[T](a: a, b: b)

func line*(a, b: Vec2): Line =
  gline[float32](a, b)

func `*`*[T, V: SomeNumber](a: GLine[T], b: V): GLine[T] =
  gline[T](a.a * b, a.b * b)

func `*`*[T, V: SomeNumber](a: V, b: GLine[T]): GLine[T] =
  b * a

func `/`*[T, V: SomeNumber](a: GLine[T], b: V): GLine[T] =
  gline[T](a.a / b, a.b / b)

func `/`*[T, V: SomeNumber](a: V, b: GLine[T]): GLine[T] =
  b / a

func `*=`*[T, V: SomeNumber](a: GLine[T], b: V): GLine[T] =
  a = a * b

func `/=`*[T, V: SomeNumber](a: GLine[T], b: V): GLine[T] =
  a = a / b

# Circle stuff

func gcirc*[T: SomeNumber](position: GVec2[T], radius: T): GCirc[T] =
  GCirc[T](position: position, radius: radius)

func circ*(position: Vec2, radius: float32): Circ =
  gcirc[float32](position, radius)

func `*`*[T, V: SomeNumber](a: GCirc[T], b: V): GCirc[T] =
  when T is V:
    gcirc[T](a.position * b, a.radius * b)
  else:
    gcirc[T](a.position * b, (a.radius.V * b).T)

func `*`*[T, V: SomeNumber](a: V, b: GCirc[T]): GCirc[T] =
  b * a

func `/`*[T, V: SomeNumber](a: GCirc[T], b: V): GCirc[T] =
  when T is V:
    gcirc[T](a.position / b, a.radius / b)
  else:
    gcirc[T](a.position / b, (a.radius.V / b).T)

func `/`*[T, V: SomeNumber](a: V, b: GCirc[T]): GCirc[T] =
  b / a

func `*=`*[T, V: SomeNumber](a: GCirc[T], b: V): GCirc[T] =
  a = a * b

func `/=`*[T, V: SomeNumber](a: GCirc[T], b: V): GCirc[T] =
  a = a / b

# Rect stuff

func grect*[T: SomeNumber](position, size: GVec2[T]): GRect[T] =
  GRect[T](position: position, size: size)

func rect*(position, size: Vec2): Rect =
  grect[float32](position, size)

func rect*(): Rect =
  Rect()

func `+`*[T: SomeNumber](a, b: GRect[T]): GRect[T] =
  grect[T](a.position + b.position, a.size + b.size)

func `-`*[T: SomeNumber](a, b: GRect[T]): GRect[T] =
  grect[T](a.position - b.position, a.size - b.size)

func `*`*[T, V: SomeNumber](a: GRect[T], b: V): GRect[T] =
  grect[T](a.position * b, a.size * b)

func `*`*[T, V: SomeNumber](a: V, b: GRect[T]): GRect[T] =
  b * a

func `/`*[T, V: SomeNumber](a: GRect[T], b: V): GRect[T] =
  grect[T](a.position / b, a.size / b)

func `/`*[T, V: SomeNumber](a: V, b: GRect[T]): GRect[T] =
  b / a

func `*=`*[T, V: SomeNumber](a: GRect[T], b: V): GRect[T] =
  a = a * b

func `/=`*[T, V: SomeNumber](a: GRect[T], b: V): GRect[T] =
  a = a / b
