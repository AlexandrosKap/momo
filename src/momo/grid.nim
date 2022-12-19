from strformat import `&`
import vector

const falseChar = '-'
const trueChar = '#'

type
  CPoint* = CVec2[int]
  Point* = GVec2[int]

  Grid*[T] = ref object
    width: int
    height: int
    cells: seq[T]
  BGrid* = Grid[bool]
  IGrid* = Grid[int32]
  UGrid* = Grid[uint32]
  FGrid* = Grid[float32]
  DGrid* = Grid[float64]

# Constructors for Point

func point*(x, y: int): Point = gvec2(x, y)
func point*(x: int): Point = gvec2(x)
func point*(): Point = gvec2(0)

# Functions for Point

func `$`*(self: Point): string =
  &"point({self.x}, {self.y})"

func `==`*(a, b: Point): bool =
  a.x == b.x and a.y == b.y

func `!=`*(a, b: Point): bool =
  not (a == b)

# Constructors for Grid

func newGrid*[T](width, height: int, value: T): Grid[T] =
  result = Grid[T](width: width, height: height)
  for i in 0 ..< width * height:
    result.cells.add(value)

func newGrid*[T](width, height: int): Grid[T] =
  newGrid[T](width, height, T.default)

func newBGrid*(width, height: int, value: bool): BGrid =
  newGrid[bool](width, height, value)

func newIGrid*(width, height: int, value: int32): IGrid =
  newGrid[int32](width, height, value)

func newUGrid*(width, height: int, value: uint32): UGrid =
  newGrid[uint32](width, height, value)

func newFGrid*(width, height: int, value: float32): FGrid =
  newGrid[float32](width, height, value)

func newDGrid*(width, height: int, value: float64): DGrid =
  newGrid[float64](width, height, value)

func newBGrid*(width, height: int): BGrid =
  newGrid[bool](width, height)

func newIGrid*(width, height: int): IGrid =
  newGrid[int32](width, height)

func newUGrid*(width, height: int): UGrid =
  newGrid[uint32](width, height)

func newFGrid*(width, height: int): FGrid =
  newGrid[float32](width, height)

func newDGrid*(width, height: int): DGrid =
  newGrid[float64](width, height)

# Functions for Grid

func width*(self: Grid): int = self.width
func height*(self: Grid): int = self.height
func cells*[T](self: Grid[T]): seq[T] = self.cells
func len*(self: Grid): int = self.width * self.height

func id*(self: Grid, x, y: int): int = y * self.width + x
func id*(self: Grid, p: CPoint): int = self.id(p.x, p.y)

func point*(self: Grid, id: int): Point =
  point(id mod self.width, id div self.width)

func set*[T](self: Grid[T], id: int, value: T) = self.cells[id] = value
func set*[T](self: Grid[T], x, y: int, value: T) = self.set(self.id(x, y), value)
func set*[T](self: Grid[T], p: CPoint, value: T) = self.set(p.x, p.y, value)

func get*[T](self: Grid[T], id: int): T = self.cells[id]
func get*[T](self: Grid[T], x, y: int): T = self.get(self.id(x, y))
func get*[T](self: Grid[T], p: CPoint): T = self.get(p.x, p.y)

func swap*(self: Grid, id1, id2: int) =
  let temp = self.get(id1)
  self.set(id1, self.get(id2))
  self.set(id2, temp)

func swap*(self: Grid, x1, y1, x2, y2: int) =
  self.swap(self.id(x1, y1), self.id(x2, y2))

func swap*(self: Grid, p1, p2: CPoint) =
  self.swap(p1.x, p1.y, p2.x, p2.y)

func fill*[T](self: Grid[T], value: T) =
  for i in 0 ..< self.len:
    self.cells[i] = value

func fill*[T](self: Grid[T], x1, y1, x2, y2: int, value: T) =
  var xa, ya, xb, yb: int
  if x1 < x2:
    xa = x1
    xb = x2
  else:
    xa = x2
    xb = x1
  if y1 < y2:
    ya = y1
    yb = y2
  else:
    ya = y2
    yb = y1
  for y in ya .. yb:
    for x in xa .. xb:
      self.set(x, y, value)

func fill*[T](self: Grid[T], p1, p2: CPoint, value: T) =
  self.fill(p1.x, p1.y, p2.x, p2.y, value)

func fill*[T](self: Grid[T], id1, id2: int, value: T) =
  self.fill(self.point(id1), self.point(id2), value)

func enclose*[T](self: Grid[T], value: T) =
  for y in 0 ..< self.height:
    if y == 0 or y == self.height - 1:
      for x in 0 ..< self.width:
        self.set(x, y, value)
    else:
      self.set(0, y, value)
      self.set(self.width - 1, y, value)

func enclose*[T](self: Grid[T], x1, y1, x2, y2: int, value: T) =
  var xa, ya, xb, yb: int
  if x1 < x2:
    xa = x1
    xb = x2
  else:
    xa = x2
    xb = x1
  if y1 < y2:
    ya = y1
    yb = y2
  else:
    ya = y2
    yb = y1
  for y in ya .. yb:
    if y == ya or y == yb:
      for x in xa .. xb:
        self.set(x, y, value)
    else:
      self.set(xa, y, value)
      self.set(xb, y, value)

func enclose*[T](self: Grid[T], p1, p2: CPoint, value: T) =
  self.enclose(p1.x, p1.y, p2.x, p2.y, value)

func enclose*[T](self: Grid[T], id1, id2: int, value: T) =
  self.enclose(self.point(id1), self.point(id2), value)

func clear*[T](self: Grid[T]) =
  self.fill(T.default)

func clear*[T](self: Grid[T], x1, y1, x2, y2: int) =
  self.fill(x1, y1, x2, y2, T.default)

func clear*[T](self: Grid[T], p1, p2: CPoint) =
  self.fill(p1, p2, T.default)

func clear*[T](self: Grid[T], id1, id2: int) =
  self.fill(id1, id2, T.default)

func isEmpty*[T](self: Grid[T], id: int): bool = self.get(id) == T.default
func isEmpty*[T](self: Grid[T], x, y: int): bool = self.isEmpty(self.id(x, y))
func isEmpty*[T](self: Grid[T], p: CPoint): bool = self.isEmpty(p.x, p.y)

func isInside*[T](self: Grid[T], id: int): bool = id >= 0 and id < self.len
func isInside*[T](self: Grid[T], x, y: int): bool = self.isInside(self.id(x, y))
func isInside*[T](self: Grid[T], p: CPoint): bool = self.isInside(p.x, p.y)

func `$`*[T](self: Grid[T]): string =
  result = ""
  for y in 0 ..< self.height:
    for x in 0 ..< self.width:
      let value = self.get(x, y)
      when T is bool:
        result.add(if value: trueChar else: falseChar)
      else:
        result.add($value)
      if x != self.width - 1:
        result.add(' ')
    if y != self.height - 1:
      result.add('\n')

func `==`*[T](a, b: Grid[T]): bool =
  a.cells == b.cells

func `!=`*[T](a, b: Grid[T]): bool =
  not a == b

iterator items*[T](self: Grid[T]): T =
  for a in self.cells:
    yield a

iterator pairs*[T](self: Grid[T]): tuple[a: int, b: T] =
  for a, b in self.cells:
    yield (a, b)
