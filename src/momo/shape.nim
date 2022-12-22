import vector

# TODO: WORKING ON IT UWU

type
  GLine*[T: SomeNumber] = object
    a*: GVec2[T]
    b*: GVec2[T]
  Line* = GLine[float32]

  GCircle*[T: SomeNumber] = object
    position*: GVec2[T]
    radius*: T
  Circle* = GCircle[float32]

  GRectangle*[T: SomeNumber] = object
    position*: GVec2[T]
    size*: GVec2[T]
  Rectangle* = GRectangle[float32]

  GPolygon*[T: SomeNumber] = seq[GVec2[T]]
  Polygon* = GPolygon[float32]

  SomeShape*[T: SomeNumber] =
    GLine[T] | GCircle[T] | GRectangle[T] | GPolygon[T]

func gline*[T: SomeNumber](a, b: GVec2[T]): GLine[T] =
  GLine[T](a: a, b: b)

func line*(a, b: Vec2): Line =
  gline[float32](a, b)

func gcircle*[T: SomeNumber](position: GVec2[T], radius: T): GCircle[T] =
  GCircle[T](position: position, radius: radius)

func circle*(position: Vec2, radius: float32): Circle =
  GCircle[float32](position: position, radius: radius)

func grectangle*[T: SomeNumber](position, size: GVec2[T]): GRectangle[T] =
  GRectangle[T](position: position, size: size)

func rectangle*(position, size: Vec2): Rectangle =
  Rectangle(position: position, size: size)
