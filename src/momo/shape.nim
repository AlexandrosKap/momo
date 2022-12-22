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

  GPolygon*[T: SomeNumber] = ref object
    position*: GVec2[T]
    points*: seq[GVec2[T]]
  Polygon* = GPolygon[float32]

  SomeShape*[T: SomeNumber] =
    GLine[T] | GCircle[T] | GRectangle[T] | GPolygon[T]
